Content-Type: multipart/mixed; boundary="===============6393975214361449215=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/4] mptcp: disable mptcp when md5sig is set on
 socket
Date: Mon, 11 Nov 2019 17:58:02 +0100
Message-ID: <20191111165802.GB19558@breakpoint.cc>
In-Reply-To: cover.1573488686.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2469

--===============6393975214361449215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> As per last public mtg discussion, md5sig will cause TCP option space
> exaustion. Without md5sig we can't exhaust the TCP option space.

How can you enable MD5SIG on an mptcp socket? I don't think its
possible, as we don't expose the subflow tcp sockets to userspace and
we don't allow setsockotps anymore.

--===============6393975214361449215==--
