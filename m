Content-Type: multipart/mixed; boundary="===============7731846765284673442=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Conference talk ideas, round 2
Date: Sun, 13 May 2018 21:02:49 -0700
Message-ID: <alpine.OSX.2.21.1805132031200.60813@gemorgan-mobl1.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 624

--===============7731846765284673442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

We had a meeting last week to discuss reshaping our netdev conference =

MPTCP talk proposal based on feedback from the committee. The plan is to =

re-focus on upstreaming concerns, challenges, and progress.

I worked on outlining some topics that might fit with the talk. I don't =

think this is exhaustive, and I'm also not saying everything here is =

required to be in the talk. I'm looking forward to your comments and =

additional ideas.


* Why is adding MPTCP to the upstream kernel complicated?

     * Differences in requirements and features from existing =

implementation

         * Every TCP socket affected vs. staying out of the way for normal =

TCP

         * Multipath protocol development and research vs giving TCP =

users/maintainers weight

     * Protocol challenges

         * Coupled receive windows across TCP subflows

         * Behavior change for duplicate acks

         * Per-packet metadata (tx path) and option writing

         * TCP option parsing - packets are currently dropped after options =

are parsed

         * Collapse/coalesce of skbs after receive - per-packet headers =

lost in TCP layer

     * Must do all this without adversely affecting TCP or networking =

structs (like sk_buff)

         * TCP performance not reduced

         * Memory requirements for TCP not increased

         * Maintainability not made harder

     * Compare to KCM, which adds metadata to each stream, didn't require =

TCP changes

* What fits well in the networking subsystem

     * Some connection code (callbacks exist)

     * Creating a new socket type for MPTCP

     * New ULP capability

         * No rules yet for multiple users, because TLS is the only user

     * In-kernel sockets

     * do_tcp_sendpages() to send data buffered at the connection level

     * tcp_read_sock() to get incoming skbs

* What's a challenge in the networking subsystem

     * Indirect calls are now more expensive

     * MPTCP builds on TCP in a unique way

* What we have tried

     * Identify where other features could use TCP extension capabilities =

and merge before MPTCP

         * Options framework used by TCP-MD5 and SMC

         * Didn't work out - expensive indirect calls and no MPTCP frame of =

reference for the maintainer

     * Sharing code demonstrating architectural approaches that use current =

upstream netdev functionality

     * Moving components to userspace

     * Forking and reducing functionality of existing MPTCP code base

* Large change logistics

     * Reshaping code in to a reviewable patch set or patch sets. Implement =

functionality in stages?

* Fundamental challenge of "show us the code" - must decide what seems =

upstreamable, implement it, share, and iterate.


Thanks,

--
Mat Martineau
Intel OTC

--===============7731846765284673442==--
