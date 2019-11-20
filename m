Content-Type: multipart/mixed; boundary="===============7336124788230348363=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 16:10:16 +0100
Message-ID: <20191120151016.GC20235@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1911191451510.15309@gpmelz-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2614

--===============7336124788230348363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > There were doubts as to the repeated invocations of mptcp_send_frag()
> > (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I have
> > dropped it from this iteration -- mptcp_sendmsg_frag needs rework which
> > isn't related to this patch series.
> =

> The series looks good to me, with one minor comment on patch 1.

Thanks, I can fix that up.

How to proceed?  There are several patches in-flight.  I think it might
make sense to apply this series as-is, with no squashing.

We can then do another squash-marathon later on before next upstream
submission.

Otherwise, I could start to squash this series here locally and then
send a pull request.

What do you think?

Thanks!
--===============7336124788230348363==--
