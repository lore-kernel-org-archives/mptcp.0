Content-Type: multipart/mixed; boundary="===============8718541780291066984=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: keep track of receivers
 advertised window
Date: Wed, 26 Aug 2020 20:44:42 +0200
Message-ID: <20200826184442.GA7319@breakpoint.cc>
In-Reply-To: alpine.OSX.2.23.453.2008251627090.25312@ticede-or-125.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5629

--===============8718541780291066984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> On Sun, 23 Aug 2020, Florian Westphal wrote:
> It looks like this would ratchet up msk->snd_wnd based on the largest
> subflow snd_wnd seen in the life of the connection.
> =

> Section 3.3.5 in the RFC says to "only update its local receive window
> values when the largest sequence number allowed (i.e., DATA_ACK + receive
> window) increases on the receipt of a DATA_ACK". So that would compare
> new_snd_una + ssk_snd_wnd and old_snd_una + sk_snd_wnd, and it would be
> possible to have mismatched values for msk->snd_wnd and msk->snd_una if
> there were concurrent reads or writes.
> =

> What if this patch added msk->wnd_end instead of msk->snd_wnd? Then the m=
sk
> window information used at transmit time would always be valid, and it
> doesn't really matter if the msk->snd_una update lags a little bit.

Sounds like a good plan, I will look into it.  Thanks for reviewing!
--===============8718541780291066984==--
