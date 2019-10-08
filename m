Content-Type: multipart/mixed; boundary="===============6681698960182607474=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Tue, 08 Oct 2019 14:15:34 +0200
Message-ID: <20191008121534.GD25052@breakpoint.cc>
In-Reply-To: dbbfa10b-975c-26f5-dca2-8abc36a6c5ef@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2045

--===============6681698960182607474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Feel free to tell me I have to do any other modifications (e.g. expose
> tcp_request_sock_ipv6_ops).

Are you done with your rebase work?

I'd like to propose another set of fixups to get rid
of refcounting and the kbuild robot warnings reported with rfcv2.

I don't want to start doing this while export is in flux.
--===============6681698960182607474==--
