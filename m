Content-Type: multipart/mixed; boundary="===============0071775448155879026=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] net/mptcp/options.c:203:3: warning: Assignment of function
 parameter has no effect outside the function.
Date: Thu, 19 Nov 2020 09:58:24 -0800
Message-ID: <1b25ebc1-47d8-e269-9511-964069a30cf@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6837

--===============0071775448155879026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Here's the static analysis kbuild notice that I mentioned in today's =

meeting. These point out a few places to clean up the code, but nothing =

urgent. While the cppcheck warnings were found on Linus' master branch I =

don't think they warrant a patch on -net. I'll send a cleanup patch based =

on net-next.

--
Mat Martineau
Intel

---------- Forwarded message ----------
Date: Thu, 19 Nov 2020 00:27:01
From: kernel test robot <rong.a.chen(a)intel.com>
Subject: net/mptcp/options.c:203:3: warning: Assignment of function paramet=
er
     has no effect outside the function.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   c2e7554e1b85935d962127efa3c2a76483b0b3b6
commit: 6d0060f600adfddaa43fefb96b6b12643331961e mptcp: Write MPTCP DSS hea=
ders to outgoing data packets
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen(a)intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

    net/mptcp/options.c:57:4: warning: Assignment of function parameter has=
 no effect outside the function. Did you forget dereferencing it? [uselessA=
ssignmentPtrArg]
       ptr +=3D 8;
       ^
>> net/mptcp/options.c:203:3: warning: Assignment of function parameter has=
 no effect outside the function. [uselessAssignmentArg]
      remaining -=3D map_size;
      ^
    net/mptcp/options.c:257:2: warning: Assignment of function parameter ha=
s no effect outside the function. [uselessAssignmentArg]
     remaining -=3D opt_size;
     ^

vim +203 net/mptcp/options.c

6d0060f600adfdd Mat Martineau 2020-01-21  177
6d0060f600adfdd Mat Martineau 2020-01-21  178  static bool mptcp_establishe=
d_options_dss(struct sock *sk, struct sk_buff *skb,
6d0060f600adfdd Mat Martineau 2020-01-21  179  					  unsigned int *size,
6d0060f600adfdd Mat Martineau 2020-01-21  180  					  unsigned int remainin=
g,
6d0060f600adfdd Mat Martineau 2020-01-21  181  					  struct mptcp_out_opti=
ons *opts)
6d0060f600adfdd Mat Martineau 2020-01-21  182  {
6d0060f600adfdd Mat Martineau 2020-01-21  183  	struct mptcp_subflow_contex=
t *subflow =3D mptcp_subflow_ctx(sk);
6d0060f600adfdd Mat Martineau 2020-01-21  184  	unsigned int dss_size =3D 0;
6d0060f600adfdd Mat Martineau 2020-01-21  185  	struct mptcp_ext *mpext;
6d0060f600adfdd Mat Martineau 2020-01-21  186  	struct mptcp_sock *msk;
6d0060f600adfdd Mat Martineau 2020-01-21  187  	unsigned int ack_size;
6d0060f600adfdd Mat Martineau 2020-01-21  188  	u8 tcp_fin;
6d0060f600adfdd Mat Martineau 2020-01-21  189
6d0060f600adfdd Mat Martineau 2020-01-21  190  	if (skb) {
6d0060f600adfdd Mat Martineau 2020-01-21  191  		mpext =3D mptcp_get_ext(sk=
b);
6d0060f600adfdd Mat Martineau 2020-01-21  192  		tcp_fin =3D TCP_SKB_CB(skb=
)->tcp_flags & TCPHDR_FIN;
6d0060f600adfdd Mat Martineau 2020-01-21  193  	} else {
6d0060f600adfdd Mat Martineau 2020-01-21  194  		mpext =3D NULL;
6d0060f600adfdd Mat Martineau 2020-01-21  195  		tcp_fin =3D 0;
6d0060f600adfdd Mat Martineau 2020-01-21  196  	}
6d0060f600adfdd Mat Martineau 2020-01-21  197
6d0060f600adfdd Mat Martineau 2020-01-21  198  	if (!skb || (mpext && mpext=
->use_map) || tcp_fin) {
6d0060f600adfdd Mat Martineau 2020-01-21  199  		unsigned int map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  200
6d0060f600adfdd Mat Martineau 2020-01-21  201  		map_size =3D TCPOLEN_MPTCP=
_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
6d0060f600adfdd Mat Martineau 2020-01-21  202
6d0060f600adfdd Mat Martineau 2020-01-21 @203  		remaining -=3D map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  204  		dss_size =3D map_size;
6d0060f600adfdd Mat Martineau 2020-01-21  205  		if (mpext)
6d0060f600adfdd Mat Martineau 2020-01-21  206  			opts->ext_copy =3D *mpext;
6d0060f600adfdd Mat Martineau 2020-01-21  207
6d0060f600adfdd Mat Martineau 2020-01-21  208  		if (skb && tcp_fin &&
6d0060f600adfdd Mat Martineau 2020-01-21  209  		    subflow->conn->sk_stat=
e !=3D TCP_ESTABLISHED)
6d0060f600adfdd Mat Martineau 2020-01-21  210  			mptcp_write_data_fin(subf=
low, &opts->ext_copy);
6d0060f600adfdd Mat Martineau 2020-01-21  211  	}
6d0060f600adfdd Mat Martineau 2020-01-21  212
6d0060f600adfdd Mat Martineau 2020-01-21  213  	ack_size =3D TCPOLEN_MPTCP_=
DSS_ACK64;
6d0060f600adfdd Mat Martineau 2020-01-21  214
6d0060f600adfdd Mat Martineau 2020-01-21  215  	/* Add kind/length/subtype/=
flag overhead if mapping is not populated */
6d0060f600adfdd Mat Martineau 2020-01-21  216  	if (dss_size =3D=3D 0)
6d0060f600adfdd Mat Martineau 2020-01-21  217  		ack_size +=3D TCPOLEN_MPTC=
P_DSS_BASE;
6d0060f600adfdd Mat Martineau 2020-01-21  218
6d0060f600adfdd Mat Martineau 2020-01-21  219  	dss_size +=3D ack_size;
6d0060f600adfdd Mat Martineau 2020-01-21  220
6d0060f600adfdd Mat Martineau 2020-01-21  221  	msk =3D mptcp_sk(mptcp_subf=
low_ctx(sk)->conn);
6d0060f600adfdd Mat Martineau 2020-01-21  222  	if (msk) {
6d0060f600adfdd Mat Martineau 2020-01-21  223  		opts->ext_copy.data_ack =
=3D msk->ack_seq;
6d0060f600adfdd Mat Martineau 2020-01-21  224  	} else {
6d0060f600adfdd Mat Martineau 2020-01-21  225  		mptcp_crypto_key_sha(mptcp=
_subflow_ctx(sk)->remote_key,
6d0060f600adfdd Mat Martineau 2020-01-21  226  				     NULL, &opts->ext_co=
py.data_ack);
6d0060f600adfdd Mat Martineau 2020-01-21  227  		opts->ext_copy.data_ack++;
6d0060f600adfdd Mat Martineau 2020-01-21  228  	}
6d0060f600adfdd Mat Martineau 2020-01-21  229
6d0060f600adfdd Mat Martineau 2020-01-21  230  	opts->ext_copy.ack64 =3D 1;
6d0060f600adfdd Mat Martineau 2020-01-21  231  	opts->ext_copy.use_ack =3D =
1;
6d0060f600adfdd Mat Martineau 2020-01-21  232
6d0060f600adfdd Mat Martineau 2020-01-21  233  	*size =3D ALIGN(dss_size, 4=
);
6d0060f600adfdd Mat Martineau 2020-01-21  234  	return true;
6d0060f600adfdd Mat Martineau 2020-01-21  235  }
6d0060f600adfdd Mat Martineau 2020-01-21  236

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============0071775448155879026==--
