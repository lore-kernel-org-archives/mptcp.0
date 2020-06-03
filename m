Content-Type: multipart/mixed; boundary="===============7584008676704680249=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: add receive buffer
 auto-tuning
Date: Wed, 03 Jun 2020 16:39:41 +0200
Message-ID: <20200603143941.GB28263@breakpoint.cc>
In-Reply-To: f67740d53f31df60e321dafeab195d020c53c3af.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4576

--===============7584008676704680249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide Caratti <dcaratti(a)redhat.com> wrote:
> hello Florian,
> =

> net-next will not be accepting patches for a while - but I would like to
> fix this on some tree, so that periodic tests can be run over there. So, I
> will rebase the fallback rework on top of the rx buffer auto-tuning patch.

Do you plan to submit your patches to net or net-next when it reopens?

If you are targetting net, it would be better to apply your patches to
the current mptcp-next tree as-is, so they don't need to be manged again
when submitted for net.

My plan wrt. autotuning is to send the selftest patch for net, and the
autotune one for net-next.  So, to me it would make more sense for your
work to go into mptcp-next first.  I would then apply the delta from
Christoph and send a new version for mptcp-next.

WDYT?
--===============7584008676704680249==--
