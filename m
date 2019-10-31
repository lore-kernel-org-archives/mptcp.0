Content-Type: multipart/mixed; boundary="===============2481449964129754826=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/6] mptcp: Reference af_ops routines through
 struct ipv4_specific
Date: Thu, 31 Oct 2019 09:33:37 +0100
Message-ID: <ff27752250167ac9a3b609ad604c4b565c38bc3a.camel@redhat.com>
In-Reply-To: 20191030233844.4790-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2372

--===============2481449964129754826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> Make this look similar to how it will have to be done for IPv6,
> as the IPv6 routines are declared static and thus not visible.
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

I think:

- 'subflow_finish_connect()' and 'inet_connection_sock_af_ops
subflow_specific;' changes should be squashed into "mptcp: Handle
MP_CAPABLE options for outgoing connections"

- 'subflow_syn_recv_sock()' into "mptcp: Create SUBFLOW socket for
incoming connections"

- 'inet_sk_rebuild_head()' into "mptcp: Add key generation and token
tree"

right?

/P


--===============2481449964129754826==--
