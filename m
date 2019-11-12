Content-Type: multipart/mixed; boundary="===============2913965928627202996=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add ack work queue
Date: Mon, 11 Nov 2019 17:04:16 -0800
Message-ID: <alpine.OSX.2.21.1911111700590.7818@mjmartin-mac01.local>
In-Reply-To: 20191111152102.GA19558@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2479

--===============2913965928627202996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Nov 2019, Florian Westphal wrote:

> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> Since mptcp_ack_work() matches closely the initial bits of
>> mptcp_retransmit(), In this specific scenario I think reusing the
>> existing worker (plus flag) would be better.
>
> Done: https://git.breakpoint.cc/cgit/fw/mptcp-next.git/commit/?h=3Dwmem_a=
cct_05&id=3Dfea55d959e29da51c605dad9c5e84544622d1b49
>
> I'll resend once others had a chance to look at this series as well.

I think the combined worker should be ok for DATA_FIN too (which Florian =

had mentioned sharing the ack workqueue with).

--
Mat Martineau
Intel
--===============2913965928627202996==--
