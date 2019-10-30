Content-Type: multipart/mixed; boundary="===============3672556325314750728=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: add primitive scheduler
Date: Thu, 31 Oct 2019 00:35:48 +0100
Message-ID: <20191030233548.GI876@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1910301621370.14540@magresha-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2363

--===============3672556325314750728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> To answer my own question: I should have taken a closer look at
> mptcp_sendmsg_frag before hitting 'send', it does look like we aren't doi=
ng
> that kind of MPTCP-level accounting yet. We might end up using a lot of
> memory if userspace keeps sending.

Yes, working on it.
--===============3672556325314750728==--
