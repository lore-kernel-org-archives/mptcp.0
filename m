Content-Type: multipart/mixed; boundary="===============5797180593726708717=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Wed, 25 Apr 2018 12:58:32 -0700
Message-ID: <alpine.OSX.2.21.1804251131080.2926@jateran-mobl1.amr.corp.intel.com>
In-Reply-To: 512756bd-89e6-712d-b68f-9fecd3103aea@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 552

--===============5797180593726708717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Matthieu -

On Fri, 20 Apr 2018, Matthieu Baerts wrote:

> Hello,
>
>
> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th, 20=
18.
>
>
> We already talked about this event on this ML and at our weekly meetings =

> but here is a summary of the discussions we had:
>
>  - we would like to have a presentation there mainly to get feedback =

> and advice from other kernel developers
>  - a presentation would clearly indicate that this MPTCP Upstream =

> project exists and we could get help from more developers
>  - we would like to indicate that having MPTCP upstream is asked by =

> different companies, some are even ready to contribute ; it is then =

> important to have MPTCP upstream
>
>
> Also note that:
>
>  - David Miller will not be present in Montr=C3=A9al [1] but other main =

> contributors should be there (we don't have a list)

Side note, in the past day David reiterated his statement about not =

attending or supporting the conference:

https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2

>  - A presentation by Octavian Purdila about "MPTCP Upstreaming" has =

> already been given in 2015 (NetDev 0.1) [2]
>  - 3 types of presentation are available: talks, tutorials and =

> workshops [3]
>  - Call for Presentation Proposals closes on May 1st, 2018.
>
>
> The current idea we briefly discussed during our weekly meetings is to =

> give a tutorial:
>
>  - It is not useful to give almost the same presentation as the one of =

> Octavian
>  - It will allow us more flexibility somehow to explain what is MPTCP, =

> the different use-cases, why it is important to have it upstream and =

> what problems we are currently facing.
>  - David Miller and many other kernel developers will go to LPC in =

> November: a good place to give a talk this time.
>
>
> Do you have any ideas on what we could show in this tutorial?
>
>
> I recently discussed with my colleague Olivier Bonaventure who has a lot =

> of experiences in giving different introductions and more about MPTCP =

> and here is what he suggests:
>
>  - A first part about a basic introduction of MPTCP
>  - Indicate different use-cases -- if possible with a "closed demo" to =

> be sure it is working -- asking people to setup something is not easy in =

> 1h, max 1h30.

From the description at [3], either "instructor-led" 60-90 minute =

tutorials or "student-participation" 2-3 hour sessions are possible. The =

closed demo maps well to their "instructor-led" category. Looking at the =

schedule, the past two Netdev Conferences have had one tutorial each, of =

60-70 minutes. I think it helps to be closer to an hour in length to hold =

the audience's attention.

>  - Then trying to have interactive discussions or explanations about =

> how MPTCP is currently implemented or should be implemented if it goes =

> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need to =

> support middleboxes, we need to link subflows of the same connection =

> together, we need a scheduler, a PM, etc.

It's difficult to predict how interactive an audience will be. I've only =

attended one Netdev Conference, and it seemed like there were a lot more =

people with expertise and interest in drivers, lower layers (XDP, BPF, TC, =

netfilter), and network topology/simulation. Discussion around middlebox =

support and the userspace API might have more audience interaction. If we =

want to drive a discussion, we could try to strike a balance between =

topics for the broader audience and those with more knowledge of TCP =

internals. (Hopefully some TCP internals people are still planning to =

attend)

>  - Of course, we should focus our discussions on the upstreaming =

> aspect, e.g. reducing the footprint of MPTCP in the current TCP stack: =

> what are we allow to do, what not. It is linked to many previous =

> discussions we had on this ML, e.g. why we need more indirect function =

> calls and how to reduce the impact, etc.

The previous talk ([2]) had a section like this. I haven't watched it =

recently, I should look at it again to see what kind of questions the =

audience was asking. As you mentioned above we should be careful to =

have new content compared to the previous session.

>  - If we have time, we could discuss about how users could interact =

> with MPTCP: enable it per connection, control the path manager, maybe =

> the scheduler, etc.
>
>
> What do you think about this? Feel free to comment and even propose =

> completely different ideas!

Thank you for outlining these ideas. I see that this topic is on our =

meeting agenda so it will be good to discuss the tutorial there.


> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
> [3] https://www.netdevconf.org/0x12/submit-proposal.html

--
Mat Martineau
Intel OTC

--===============5797180593726708717==--
