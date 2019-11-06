Content-Type: multipart/mixed; boundary="===============4815840552135845979=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 3/4] protocol: use sk_wait_event helper
Date: Wed, 06 Nov 2019 16:58:03 +0100
Message-ID: <dbc2fc20-dd83-a62b-421f-29c649246b00@tessares.net>
In-Reply-To: 20191106150909.GA31295@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2428

--===============4815840552135845979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Paolo,

On 06/11/2019 16:09, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> sk_wait_event is a macro that evaluates its third arg twice (but we've
>> discussed this before: https://lists.01.org/hyperkitty/list/mptcp(a)list=
s.01.org/thread/7HAWM43BLQVRBNIPV5II7C2WGTARAMDR/#7S54V7TAZUXZEUXVANQZ3OETQ=
MPQGK6J),
>> but in this case the second check of the flag is likely to be an inexpen=
sive
>> READ_ONCE() on a hot cache line. So, the extra code was there a reason b=
ut
>> I'm ok with merging this for maintainability purposes.
> =

> We can also drop it.  Its likely this needs to be rewritten again in
> the future.
> =

> I'd like to get rid of __tcp_poll() and make mptcp_poll standalone.
> =

> For that to work reliably its needed that the mptcp sk has a reliable
> indicator that there is data available.
> =

> Right now this isn't the case because the bit is cleared immediately
> on mptcp_recvmsg entry.
> =

> Removing the clear_bit could get us in a state where the bit is still
> set, but the last recvmsg did drain the last byte.
> =

> Checking the ssk read queue and clearing the bit on revmsg exit doesn't
> work either because we could have data available in another subflow,
> but walking the subflow list isn't exactly ideal.

Thank you for the patches and the reviews.
Is it then OK if I apply this series as it is?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4815840552135845979==--
