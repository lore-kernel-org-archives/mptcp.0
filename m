Content-Type: multipart/mixed; boundary="===============4921614365266957491=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: rare MPTCP self-test failure
Date: Tue, 17 Mar 2020 19:44:47 +0100
Message-ID: <6a95827911a74bea6d9ab80b1baef5baa3b78fa9.camel@redhat.com>
In-Reply-To: 2db8d1791296de302ae821aa7fecb64957056ea9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3969

--===============4921614365266957491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-17 at 17:52 +0100, Paolo Abeni wrote:
> It looks like we need an additional __mptcp_flush_join_list() in
> mptcp_shutdown(). I'll test a patch ASAP.

That is not enough. We still have a race between mptcp_finish_join()
and mptcp_stream_accept() if MPJ completes before accept() the MPJ
subflow does not land into join_list. More patches in the work

/P

--===============4921614365266957491==--
