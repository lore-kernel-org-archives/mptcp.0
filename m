Content-Type: multipart/mixed; boundary="===============8307535152066766663=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Wed, 25 Nov 2020 11:06:25 +0100
Message-ID: <613bb9f26a3056cc637319c444aea9e93b8002f0.camel@redhat.com>
In-Reply-To: e13e47c7e041e577598101df70bd7e64e789b61e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6924

--===============8307535152066766663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 10:54 +0100, Paolo Abeni wrote:
> Note: I think this later change is actually an independed bug fix, I
> fear a peer sending an MP_JOIN with an invalid token will get back an
> MPJ_SYNACK, while the subflow_req->msk will be cleared. Later
> in subflow_syn_recv_sock(), we will probably get a NULL ptr dereference
> in mptcp_can_accept_new_subflow().
> =

> @Davide: can we somehow easily check the above with a packet drill?
> =

> Thanks!

yes I can try that. I'm now looking once again at the MP_JOIN script
(issue #94) and trying to fix this in a way or another (the problem is
apparently bad values of [s,c]addr[0,1] in the environment. But at least
generation of an inbound MP_JOIN SYN should be under control. I do a
quicjk tyest and let you know, ok?

-- =

davide

--===============8307535152066766663==--
