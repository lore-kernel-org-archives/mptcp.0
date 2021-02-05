Content-Type: multipart/mixed; boundary="===============2428942730469933268=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: better msk receive window updates
Date: Fri, 05 Feb 2021 12:51:26 +0100
Message-ID: <20210205115126.GD16570@breakpoint.cc>
In-Reply-To: fcdc881ffcbb714ca8693f3c2cbfd15f623d969c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7635

--===============2428942730469933268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> In teory, even MPTCP level retransmissions should kick-in, but the
> current pkt scheduler implementation for re-injection
> (mptcp_subflow_get_retrans) always decice to do nothing, as the subflow
> is _not_ in a lossy CA state.

Retrans skips subflows in lossy CA state, not the other way around?
--===============2428942730469933268==--
