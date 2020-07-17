Content-Type: multipart/mixed; boundary="===============0632604716144407283=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: explicitly zeros msk fields on clone
Date: Fri, 17 Jul 2020 17:30:46 +0200
Message-ID: <19266193fa938c42a6d304d0bae824a20137e950.camel@redhat.com>
In-Reply-To: 539a0cd36a6ff12d3b8d702a2cb314925a32cd9f.1594996220.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5076

--===============0632604716144407283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-07-17 at 17:12 +0200, Paolo Abeni wrote:
> sk_clone_lock() does not set the __GFP_ZERO flag on the
> internal socket allocation, so we must explicitly zero
> all the relevant msk fields, or we could see inconsitent
> socket status leading to unexpected fallback or data
> corruption.

I noticed only after sending this that sk_clone_lock() calls
sock_copy() which in turn copies everything up to prot->obj_size - that
is sizeof(struct mptcp_sock) or sizeof(struct mptcp6_sock) in our
case).

Since the listening socket should always have the relevant fields
cleared this patch is not needed.

There is a caveat: a socket could go through:

 connect(); shutdown(); listen(); =


but I think the correct way to handle the above is clearing properly
the status in listen(), will look at that later

/P

--===============0632604716144407283==--
