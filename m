Content-Type: multipart/mixed; boundary="===============4515661685980441869=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/12] pm netlink: followup and fixes
Date: Wed, 04 Mar 2020 19:56:09 +0100
Message-ID: <d26beb71fd0c5b5469b4ec3c3b31d5639805f4e3.camel@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3863

--===============4515661685980441869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-04 at 16:01 +0100, Paolo Abeni wrote:
> Note: mp join self tests are still unstable, e.g. can fail randomly, due =
to an
> old race between mptcp_token_update_accept() and mptcp_token_get_sock(): =
e.g.
> a client may legitly try to create a subflow after that the first one is =
fully
> established but before the server has accepted the initial socket:
> mptcp_token_get_sock() will fail and MP_JOIN will fail too, incrementing
> MPTCP_MIB_JOINNOTOKEN.

I'm looking at the above issue. =


I think we can address it allocating earlier the msk socket in
subflow_syn_recv_sock(), so that we can always insert the 'token ->
msk' association into the radix tree before entering the fully
established status.

As a nice side effect mptcp_connect() will be simpler and faster.

The flip side is more memory allocated for the child socket backlog (I
think it should not be that bad, as the child backlog is limited).

I hope to share some early code soon. (will be a separate series
anyway)

Any comments/opinion/warns ?!?

Thanks,

Paolo



--===============4515661685980441869==--
