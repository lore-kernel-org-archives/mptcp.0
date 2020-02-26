Content-Type: multipart/mixed; boundary="===============8817714163799707079=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 10:36:47 +0100
Message-ID: <20200226093647.GN19559@breakpoint.cc>
In-Reply-To: 415469e83738415aa2d6e99a9237c8e5468ea23c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3805

--===============8817714163799707079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> I see! Yes, currently we can't limit the number of subflows created for
> a single mptcp socket on a server. I'm unsure how bad that is, as
> usually we allow each client to create an arbitrary high number of TCP
> connection to the server (modulo syn flood).
> =

> Still I think adding the ability to impose such limit could be nice. It
> requires an additional hook (from subflow_syn_recv_sock() towards the
> PM). If we agree on that, I can try to cover in a separate
> patch/series.

I think its a must-have, as file descriptor limits don't apply.
--===============8817714163799707079==--
