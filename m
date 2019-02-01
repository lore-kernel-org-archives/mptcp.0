Content-Type: multipart/mixed; boundary="===============6651759294102060314=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 31st of January 2019
Date: Fri, 01 Feb 2019 16:04:29 +0100
Message-ID: <4ba73b49-6dae-8374-2d5c-74f656817eb2@tessares.net>
In-Reply-To: 20190131181918.ozgepblvdhdz353v@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 987

--===============6651759294102060314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for your answer here!

On 31/01/2019 19:19, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> =

> Thanks for the summary.
> =

> [..]
> =

>> Mat and Peter's new patch-set:
>>     - Florian mentioned that it could be nice to add a kselftest. We
>> need to check how other network protocols are doing their kselftests.
> =

> Ok, I'll handle this, no problem.

Great, thank you!

>> Florian. We report this discussion to next week. Here are the questions
>> to discuss:
>>     - focus on the first patch-set and try to upstream this base?
> =

> Is that t/upstream / mmartineau-init-mptcp-v5?

The goal would be to integrate "accepted" commits. In other words, all
the ones with a +2 starting from:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437388/6

They would be integrated in mptcp_net-next repo, between 'net-next' and
't/upstream'. I don't know if you are familiar with Topgit but yes,
these commits will be in 't/upstream' (with other "merge" commits).

I will look at automating the export of these commits on top of
'net-next': to always have "proper" commits on top of latest net-next
for people interesting in commit messages, not only in code.

> If so, +1 from me.
> =

> Only question from my side:
> =

>>     - testing? (packetdrill?)
> =

> I think the initial submission should come with a simple
> self-test, i.e. {client,server}.c + a shell script to glue those
> together.  Just to exercise most basic mptcp code paths.
> =

> They can be extended (like add/remove subflows) when those features
> are added.

That's a good idea to have that also to show an example of how to add
MPTCP support to a client/server app!

> Getting mptcp packetdrill support would be great of course,
> but I think its something that should be focused on later on
> to handle/test/validate wire-protocol.

If you want, there is already a version of Packetdrill that supports
MPTCP: https://github.com/aschils/packetdrill_mptcp

There are a few known issues and the code is not upstreamable like that
but if we can already use it like that, that's better than nothing :)

If later one we can develop a version of packetdrill based on latest
Google's version that would be really nice!

>>     - We propose to have the next one on Thursday, the 7th of February.
> =

> Good, I should be able to attend again (I'm barely functional due some
> virus).

Take care :)

Have a good day,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6651759294102060314==--
