Content-Type: multipart/mixed; boundary="===============7781049017467350147=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 13/14] sendmsg: don't restart mptcp_sendmsg_frag
Date: Mon, 18 Nov 2019 22:44:39 +0100
Message-ID: <20191118214439.GD2284@breakpoint.cc>
In-Reply-To: d93aafe7ca2a65d0e0ebaafc0e0d76eb917d6068.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2584

--===============7781049017467350147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> I have no objections on this change.
> =

> Cheers,
> =

> Paolo
> =

> p.s. we will likely have to touch sendmsg_frag() again to fix the issue
> reported by Matt.

Ok, I will submit a v2 *without* this change.  We
can then probably better figure out how to handle this.

(We can also keep requirements for future .sendpage in mind).
--===============7781049017467350147==--
