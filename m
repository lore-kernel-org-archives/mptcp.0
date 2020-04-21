Content-Type: multipart/mixed; boundary="===============4289030848602958483=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] clearing mptcpRX options
Date: Tue, 21 Apr 2020 18:23:36 +0200
Message-ID: <aa888dbe6aef3fb2b38ec631ea4b8d9aba0e1188.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4212

--===============4289030848602958483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi all,

currently we hook mptcp rx option clearing inside tcp_clear_options().
It looks like it's not enough, as tcp_clear_options() is not called
before each tcp_parse_options(). =


Overall effect I can observe is that mptcp_incoming_options() sees
opt_rx->mptcp.mp_capable =3D=3D 1, while the current packet does not carry
any MP_CAPABLE option.

Am I missing anything important here?!?

A trivial fix would be moving:

#if IS_ENABLED(CONFIG_MPTCP)
        opt_rx->mptcp.mp_capable =3D 0;
        opt_rx->mptcp.mp_join =3D 0;
        opt_rx->mptcp.add_addr =3D 0;
        opt_rx->mptcp.rm_addr =3D 0;
        opt_rx->mptcp.dss =3D 0;
+#endif

from tcp_clear_options() to tcp_parse_options(), but I feel dizzy to
touch the TCP code again. Perhaps we should consider aliasing/unioning
the above fields with a single 'sub_opts' byte so we can clear them at
once?

Additionally, it now looks like to me that the TCP code stores very
little per packet information in 'opt_rx'. Should we try to move most
MPTCP per packet information out of mptcp_options_received, too ?!?

Thanks,

Paolo

--===============4289030848602958483==--
