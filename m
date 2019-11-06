Content-Type: multipart/mixed; boundary="===============9092891899301992710=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 3/4] protocol: use sk_wait_event helper
Date: Wed, 06 Nov 2019 16:09:09 +0100
Message-ID: <20191106150909.GA31295@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1911051123570.27697@cavianch-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2426

--===============9092891899301992710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> sk_wait_event is a macro that evaluates its third arg twice (but we've
> discussed this before: https://lists.01.org/hyperkitty/list/mptcp(a)lists=
.01.org/thread/7HAWM43BLQVRBNIPV5II7C2WGTARAMDR/#7S54V7TAZUXZEUXVANQZ3OETQM=
PQGK6J),
> but in this case the second check of the flag is likely to be an inexpens=
ive
> READ_ONCE() on a hot cache line. So, the extra code was there a reason but
> I'm ok with merging this for maintainability purposes.

We can also drop it.  Its likely this needs to be rewritten again in
the future.

I'd like to get rid of __tcp_poll() and make mptcp_poll standalone.

For that to work reliably its needed that the mptcp sk has a reliable
indicator that there is data available.

Right now this isn't the case because the bit is cleared immediately
on mptcp_recvmsg entry.

Removing the clear_bit could get us in a state where the bit is still
set, but the last recvmsg did drain the last byte.

Checking the ssk read queue and clearing the bit on revmsg exit doesn't
work either because we could have data available in another subflow,
but walking the subflow list isn't exactly ideal.

--===============9092891899301992710==--
