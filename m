Content-Type: multipart/mixed; boundary="===============8539476735578455744=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
Date: Fri, 04 Dec 2020 00:54:15 +0100
Message-ID: <20201203235415.GD5710@breakpoint.cc>
In-Reply-To: CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7031

--===============8539476735578455744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul(a)paul-moore.com> wrote:
> I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> the else-crud chunk.  Just to confirm my understanding, while MPTCP
> allows one TCP connection/stream to be subdivided and distributed
> across multiple interfaces, it does not allow multiple TCP streams to
> be multiplexed on a single connection, yes?

Its the latter.  The application sees a TCP interface (socket), but
data may be carried over multiple individual tcp streams on the wire.
--===============8539476735578455744==--
