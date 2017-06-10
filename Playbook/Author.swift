//
//  Authors.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/3/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import UIKit

public struct Author {
    var name: String
    var picture: UIImage
    var description: String
    var isPopular: Bool
}

public var authors: [Author] = [
    
    Author(name: "Brian Balfour",
           picture: #imageLiteral(resourceName: "brianBalfour"),
           description: "Founder/CEO of Reforge, previously VP Growth @ HubSpot",
           isPopular: false),
    Author(name: "Sujan Patel",
           picture: #imageLiteral(resourceName: "sujanPatel"),
           description: "Digital marketing strategy @ Fortune 500 companies.",
           isPopular: false),
    Author(name: "Ehsan Jahandarpour",
           picture: #imageLiteral(resourceName: "ehsanJahandarpour"),
           description: "Forbes Top 20 Growth Hackers 2016. Ex Microsoft.",
           isPopular: false),
    Author(name: "Andrew Chen",
           picture: #imageLiteral(resourceName: "andrewChen"),
           description: "Head of Rider Growth at Uber",
           isPopular: true),
    Author(name: "Noah Kagan",
           picture: #imageLiteral(resourceName: "noahKagan"),
           description: "Chief Sumo at Sumo and AppSumo and #4 at Mint.",
           isPopular: true),
    Author(name: "Paul Graham",
           picture: #imageLiteral(resourceName: "paulGraham"),
           description: "Programmer, writer, and investor. Founder of Y Combinator.",
           isPopular: true),
    Author(name: "Sam Altman",
           picture: #imageLiteral(resourceName: "samAltman"),
           description: "President of Y Combinator and co-chairman of OpenAI.",
           isPopular: false),
    Author(name: "Seth Godin",
           picture: #imageLiteral(resourceName: "sethGodin"),
           description: "Author of 18 books that have been bestsellers.",
           isPopular: true),
    Author(name: "Tim Ferriss",
           picture: #imageLiteral(resourceName: "timFerriss"),
           description: "Author of The 4-Hour Workweek.",
           isPopular: true),
    Author(name: "Neil Patel",
           picture: #imageLiteral(resourceName: "neilPatel"),
           description: "Entrepreneur, investor & influencer.",
           isPopular: true),
    Author(name: "OnStartups",
           picture: #imageLiteral(resourceName: "onstartups-logo"),
           description: "This blog is for and about software startups.",
           isPopular: false),
    Author(name: "Isaac Moorehouse",
           picture: #imageLiteral(resourceName: "isaacMoorehouse"),
           description: "Founder of Praxis, an awesome startup apprenticeship program.",
           isPopular: false),
    Author(name: "Farnam Street",
           picture: #imageLiteral(resourceName: "farnamStreet"),
           description: "Helping you understand how the world works.",
           isPopular: true),
    Author(name: "Hiten Shah",
           picture: #imageLiteral(resourceName: "hiltenShah"),
           description: "Started a few SaaS companies, CrazyEgg, KISSmetrics & Quick Sprout.",
           isPopular: false),
    Author(name: "Avinash Kaushik",
           picture: #imageLiteral(resourceName: "avinashKaushik"),
           description: "Occam's Razor - Digital Marketing Evangelist for Google.",
           isPopular: false),
    Author(name: "James Clear",
           picture: #imageLiteral(resourceName: "jamesClear"),
           description: "Writing about habits and human potential.",
           isPopular: false),
    Author(name: "Zen Habits",
           picture: #imageLiteral(resourceName: "Res-zenhabits-Logo"),
           description: "Zen Habits is about finding simplicity and mindfulness in our lives.",
           isPopular: false),
    Author(name: "Jonathan Fields",
           picture: #imageLiteral(resourceName: "jonathanFields"),
           description: "A dad, husband, serial entrepreneur, and growth strategist.",
           isPopular: false),
    Author(name: "Mark Manson",
           picture: #imageLiteral(resourceName: "markManson"),
           description: "Author of The Subtle Art of Not Giving a Fuck.",
           isPopular: false),
    Author(name: "Steve Blank",
           picture: #imageLiteral(resourceName: "steveBlank"),
           description: "A Silicon Valley serial-entrepreneur and academician.",
           isPopular: false),
    Author(name: "Copyblogger",
           picture: #imageLiteral(resourceName: "copyBlogger"),
           description: "Teaching people how to create killer online content since 2006.",
           isPopular: false),
    Author(name: "ConversionXL",
           picture: #imageLiteral(resourceName: "conversionsXL"),
           description: "Latest research on conversion optimization and data-driven growth.",
           isPopular: false),
    Author(name: "For Entrepreneurs",
           picture: #imageLiteral(resourceName: "forEntrepreneurs"),
           description: "My name is David Skok, and I am a serial entrepreneur turned VC.",
           isPopular: false),
    Author(name: "Derek Sivers",
           picture: #imageLiteral(resourceName: "derekSivers"),
           description: "I’m fascinated with psychology of self-improvement and business.",
           isPopular: false),
    Author(name: "Intercom",
           picture: #imageLiteral(resourceName: "intercom"),
           description: "We make customer communication simple and personal",
           isPopular: false),
    Author(name: "Social Triggers",
           picture: #imageLiteral(resourceName: "socialTriggers"),
           description: "Expert marketer and entrepreneur.",
           isPopular: false),
    Author(name: "Rand Fishkin",
           picture: #imageLiteral(resourceName: "randFishkin"),
           description: "Founder and former CEO of SEO software startup Moz",
           isPopular: false),
    Author(name: "Tom Tunguz",
           picture: #imageLiteral(resourceName: "tomTunguz"),
           description: "I'm a partner at Redpoint. I write about key questions facing startups.",
           isPopular: false),
    Author(name: "Sixteen Ventures",
           picture: #imageLiteral(resourceName: "sixteenVentures"),
           description: "Customer Success Consultant focused on Customer Success-driven Growth",
           isPopular: false),
    Author(name: "Buffer Blog",
           picture: #imageLiteral(resourceName: "buffer"),
           description: "The best way to drive traffic and save time on social media.",
           isPopular: false),
    Author(name: "Both Sides of the Table",
           picture: #imageLiteral(resourceName: "bothSidesOfTheTable"),
           description: "Perspectives of a 2x entrepreneur turned VC at UpfrontVC",
           isPopular: true),
    Author(name: "AVC",
           picture: #imageLiteral(resourceName: "avc"),
           description: "I am Fred Wilson. I am a VC. I have been since 1986.",
           isPopular: false),
    Author(name: "Andreessen Horowitz",
           picture: #imageLiteral(resourceName: "andreessenHorowitz"),
           description: "Backs entrepreneurs who are building the next major franchises in tech.",
           isPopular: false),
    Author(name: "Jeff Hilimire",
           picture: #imageLiteral(resourceName: "jeffHilimire"),
           description: "Startups, leadership, mobile apps/marketing, and doing good.",
           isPopular: false),
    Author(name: "KlientBoost",
           picture: #imageLiteral(resourceName: "klientBoost"),
           description: "The ppc and cro idea factory",
           isPopular: false),
    Author(name: "Digital Marketer",
           picture: #imageLiteral(resourceName: "digitalMarketer"),
           description: "Online community for digital marketing professionals.",
           isPopular: true),
    Author(name: "A Better Lemonade Stand",
           picture: #imageLiteral(resourceName: "aBetterLemonadeStand"),
           description: "An online ecommerce incubator.",
           isPopular: false),
    Author(name: "Brian Dean",
           picture: #imageLiteral(resourceName: "brianDean"),
           description: "Where professional marketers turn for proven SEO advice.",
           isPopular: false),
    Author(name: "Matthew Barby",
           picture: #imageLiteral(resourceName: "matthewBarby"),
           description: "Global Head of Growth & SEO at HubSpot",
           isPopular: false),
    Author(name: "Ryan Holiday",
           picture: #imageLiteral(resourceName: "ryanHoliday"),
           description: "Former director of marketing at American Apparel.",
           isPopular: false),
    Author(name: "A Life of Productivity",
           picture: #imageLiteral(resourceName: "aLifeOfProductivity"),
           description: "I have always been fascinated by productivity.",
           isPopular: false),
    Author(name: "Stephen Wolfram",
           picture: #imageLiteral(resourceName: "stephenWolfram"),
           description: "Stephen Wolfram is the creator of Mathematica and Wolfram Alpha.",
           isPopular: false),
    Author(name: "Think Growth",
           picture: #imageLiteral(resourceName: "thinkGrowth"),
           description: "Stories, insights, & ideas to help you and your business grow",
           isPopular: false),
    Author(name: "Eric Ries",
           picture: #imageLiteral(resourceName: "ericRies"),
           description: "The creator of the Lean Startup methodology.",
           isPopular: false),
    Author(name: "I Will Teach You To Be Rich",
           picture: #imageLiteral(resourceName: "iWillTeachYouToBeRich"),
           description: "Learn how to use psychology and systems to live a Rich Life.",
           isPopular: false),
    Author(name: "David Cummings",
           picture: #imageLiteral(resourceName: "davidCummings"),
           description: "Tech entrepreneur who enjoys family, startups, and sports.",
           isPopular: false),
    Author(name: "Smart Passive Income",
           picture: #imageLiteral(resourceName: "smartPassiveIncome"),
           description: "Proven strategies for running an online business.",
           isPopular: false),
    Author(name: "James Altucher",
           picture: #imageLiteral(resourceName: "jamesAltucher"),
           description: "Hedge fund manager, entrepreneur, and author.",
           isPopular: false),
    Author(name: "Brad Feld",
           picture: #imageLiteral(resourceName: "bradFeld"),
           description: "Early stage investor and entrepreneur since 1987.",
           isPopular: false),
    Author(name: "Stratechery",
           picture: #imageLiteral(resourceName: "stratechery"),
           description: "I write about technology with a focus on strategy and business.",
           isPopular: false),
    Author(name: "Signal v. Noise",
           picture: #imageLiteral(resourceName: "signalVNoise"),
           description: "Strong opinions and shared thoughts by the makers of Basecamp.",
           isPopular: false),
    Author(name: "500 Startups",
           picture: #imageLiteral(resourceName: "500Startups"),
           description: "Startup accelerator. Dave McClure",
           isPopular: false),
    Author(name: "Chris Brogan",
           picture: #imageLiteral(resourceName: "chrisBrogan"),
           description: "CEO of Owner Media Group, providing strategy for the modern business.",
           isPopular: false),
    Author(name: "Entrepreneur On Fire",
           picture: #imageLiteral(resourceName: "entrepreneurOnFire"),
           description: "I interview today’s most inspiring Entrepreneurs 7 days a week!",
           isPopular: false),
    Author(name: "Duct Tape Marketing",
           picture: #imageLiteral(resourceName: "ductTapeMarketing"),
           description: "Simple, Effective, Affordable Small Business Marketing.",
           isPopular: false),
    Author(name: "Lean Startup Co.",
           picture: #imageLiteral(resourceName: "leanStartupCo"),
           description: "Helping entrepreneurs build better products using lean methodology.",
           isPopular: false),
    Author(name: "Wait But Why",
           picture: #imageLiteral(resourceName: "waitButWhy"),
           description: "Long form content on AI, procrastination, outer space, etc.",
           isPopular: false),
    Author(name: "Ribbon Farm",
           picture: #imageLiteral(resourceName: "ribbonFarm"),
           description: "Blog devoted to unusual takes on familiar themes.",
           isPopular: false),
    Author(name: "Baked Suyo (Eric Barker)",
           picture: #imageLiteral(resourceName: "bakedSuyoEricBarker"),
           description: "This site brings you science-based insight on life.",
           isPopular: false),
    Author(name: "Coding Horror",
           picture: #imageLiteral(resourceName: "codingHorror"),
           description: "Founder of stackoverflow.com",
           isPopular: false),
    Author(name: "Quicksprout",
           picture: #imageLiteral(resourceName: "quickSprout"),
           description: "An easier way to learn online marketing",
           isPopular: false),
    Author(name: "Benjamin Hardy",
           picture: #imageLiteral(resourceName: "benHardy"),
           description: "Author / Medium.com #1 writer / Ph.D. candidate",
           isPopular: false),
    Author(name: "Product Hunt Blog",
           picture: #imageLiteral(resourceName: "productHunt"),
           description: "The place to discover your next favorite thing",
           isPopular: false),
    Author(name: "Larry Kim",
           picture: #imageLiteral(resourceName: "larryKim"),
           description: "Founder of WordStream. Most influential PPC expert in '15, '14 and '13.",
           isPopular: false),
    Author(name: "Nir Eyal",
           picture: #imageLiteral(resourceName: "nirEyal"),
           description: "Author of Hooked: How to Build Habit-Forming Products",
           isPopular: false),
    Author(name: "Cal Newport",
           picture: #imageLiteral(resourceName: "calNewport"),
           description: "Decoding patterns of success",
           isPopular: false),
    Author(name: "Y Combinator",
           picture: #imageLiteral(resourceName: "yCombinator"),
           description: "Y Combinator provides seed funding for startups.",
           isPopular: false),
    Author(name: "Sam Harris",
           picture: #imageLiteral(resourceName: "samHarris"),
           description: "Neuroscience, moral philosophy, religion, meditation practice",
           isPopular: false),
    Author(name: "Scott Adams (Dilbert)",
           picture: #imageLiteral(resourceName: "scottAdams"),
           description: "Founder of Dilbert",
           isPopular: false),
    Author(name: "Jon Loomer",
           picture: #imageLiteral(resourceName: "johnLoomer"),
           description: "For advanced Facebook marketers",
           isPopular: false),
    Author(name: "Convince and Convert",
           picture: #imageLiteral(resourceName: "convinceAndConvert"),
           description: "Strategic advisors that make digital marketing remarkable.",
           isPopular: false),
    Author(name: "Jeff Bullas",
           picture: #imageLiteral(resourceName: "jeffBullas"),
           description: "Win at business and life in a digital world",
           isPopular: false),
    Author(name: "Kopywriting Kourse",
           picture: #imageLiteral(resourceName: "kopywritingKourse"),
           description: "We’re half copywriting agency, and half copywriting training.",
           isPopular: false),
    Author(name: "Casey Accidental",
           picture: #imageLiteral(resourceName: "caseyAccidental"),
           description: "Former growth lead at Pinterest. First marketer at GrubHub.",
           isPopular: false),
    Author(name: "A Smart Bear",
           picture: #imageLiteral(resourceName: "aSmartBear"),
           description: "I’m the founder of Smart Bear, WP Engine, and two others.",
           isPopular: false),
    
]





