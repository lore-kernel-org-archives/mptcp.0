Content-Type: multipart/mixed; boundary="===============0010466716353772028=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fall back to tcp when dss checksum are
 requested
Date: Mon, 26 Aug 2019 20:11:32 +0200
Message-ID: <20190826181132.GX20113@breakpoint.cc>
In-Reply-To: f08c3a3f262768ef4ce96849900b027cf15e7f8d.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1711

--===============0010466716353772028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Peter Krystad <peter.krystad(a)linux.intel.com> wrote:
> =

> Hi Florian -
> =

> My thinking here was that code in mptcp_parse_options() just parses the
> options without having knowledge about configuration. There is existing l=
ogic
> for peer requesting checksums in subflow_v4_init_req().

Uh, I don't understand this then.  Can you fix this?

mptcp-next can't talk to mptcp kernel unless one disables checksums on
the mptcp kernel.

mptcp (out of tree) excepts checksums in default settings and will reset
the connection quickly.  I don't see how to fallback to tcp in that case
except with the patch I sent (not setting mp capable).

Thanks.

--===============0010466716353772028==--
