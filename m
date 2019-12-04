Content-Type: multipart/mixed; boundary="===============1138536731376345650=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: fix option length of mp_capable syn/ack
Date: Wed, 04 Dec 2019 11:35:53 -0800
Message-ID: <87a9f579567e428774ae6a00858daad663f0831a.camel@linux.intel.com>
In-Reply-To: 6941c970fd9ce038972887af590fc685746f4427.1575279172.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2784

--===============1138536731376345650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Davide -

On Mon, 2019-12-02 at 11:04 +0100, Davide Caratti wrote:
> in current MPTCP, the server sends the client's key back in the syn/ack
> packet. Because of that, both tcpdump and packetdrill refuse to parse
> the mp_capable option in the syn/ack. Both RFC6824 and RFC6824bis don't
> require this in section 3.1, only the server's key should be sent in
> the syn/ack.
> =

> - change TCPOLEN_MPTCP_MPC_SYNACK from 20 (4+8+8) to 12 (4+8)
> - don't write the client's key in mp_capable syn/ack
> - adjust tests in mptcp_parse_option() to cope with the changed
>   value of TCPOLEN_MPTCP_MPC_SYNACK
> =

> 3-way handshakes obtained with
> =

>  # ./mptcp_connect.sh -4 -c -e tx
>  [...]
>  # tcpdump -c3 -tnnr ns1-5de04ec0-TGs4tf-ns1-5de04ec0-TGs4tf-MPTCP-MPTCP-=
10.0.1.1.pcap tcp
> =

> unpatched kernel:
> =

>  IP 10.0.1.1.49752 > 10.0.1.1.10000: Flags [S], seq 2594718977, win 65535=
, options [mss 65495,sackOK,TS val 3944347269 ecr 0,nop,wscale 8,mptcp capa=
ble {0xf931b304deb39a42}], length 0
>  IP 10.0.1.1.10000 > 10.0.1.1.49752: Flags [S.], seq 3996234497, ack 2594=
718978, win 65535, options [mss 65495,sackOK,TS val 3944347270 ecr 39443472=
69,nop,wscale 8,mptcp capable[bad opt]>
> ^^^ bad option
>  IP 10.0.1.1.49752 > 10.0.1.1.10000: Flags [.], ack 1, win 256, options [=
nop,nop,TS val 3944347270 ecr 3944347270,mptcp capable {0xf931b304deb39a42,=
0x96614f185e633ce}], length 0
> =

> patched kernel:
> =

>  IP 10.0.1.1.50850 > 10.0.1.1.10000: Flags [S], seq 626898452, win 65495,=
 options [mss 65495,sackOK,TS val 2266878231 ecr 0,nop,wscale 7,mptcp capab=
le {0x7fe37bfd872b9f9f}], length 0
>  IP 10.0.1.1.10000 > 10.0.1.1.50850: Flags [S.], seq 3966041155, ack 6268=
98453, win 65483, options [mss 65495,sackOK,TS val 2266878232 ecr 226687823=
1,nop,wscale 7,mptcp capable {0x8a167e3af39b5fc1}], length 0
> ^^^ no more bad option
>  IP 10.0.1.1.50850 > 10.0.1.1.10000: Flags [.], ack 1, win 512, options [=
nop,nop,TS val 2266878232 ecr 2266878232,mptcp capable {0x7fe37bfd872b9f9f,=
0x8a167e3af39b5fc1}], length 0
> =

> v2: more conservative behavior when parsing received options
> v3: adjust tests in mptcp_parse_option() to catch all possible
>     values of MP_CAPABLE option length specified by v0 protocol,
>     thanks Matthieu Baerts.
> =

> Fixes: 8fa520f034ed ("mptcp: Handle MPTCP TCP options")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/options.c  | 7 +++----
>  net/mptcp/protocol.h | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 98eb0281d196..eb29da31c7bd 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -25,7 +25,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
>  	 */
>  	case MPTCPOPT_MP_CAPABLE:
>  		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
> -		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
> +		    opsize !=3D TCPOLEN_MPTCP_MPC_ACK)
>  			break;
>  =

>  		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
> @@ -57,7 +57,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
>  		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>  		ptr +=3D 8;
>  =

> -		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> +		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK) {
>  			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
>  			ptr +=3D 8;
>  			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
> @@ -650,8 +650,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
>  				      MPTCP_CAP_HMAC_SHA1);
>  		put_unaligned_be64(opts->sndr_key, ptr);
>  		ptr +=3D 2;
> -		if ((OPTION_MPTCP_MPC_SYNACK |
> -		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> +		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
>  			put_unaligned_be64(opts->rcvr_key, ptr);
>  			ptr +=3D 2;
>  		}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index acad61c70de9..10347c9b4dff 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -34,7 +34,7 @@
>  =

>  /* MPTCP suboption lengths */
>  #define TCPOLEN_MPTCP_MPC_SYN		12
> -#define TCPOLEN_MPTCP_MPC_SYNACK	20
> +#define TCPOLEN_MPTCP_MPC_SYNACK	12
>  #define TCPOLEN_MPTCP_MPC_ACK		20
>  #define TCPOLEN_MPTCP_MPJ_SYN		12
>  #define TCPOLEN_MPTCP_MPJ_SYNACK	16

This is minor but I think for clarity in mptcp_synack_options() we should
remove the line that copies the remote_key into the option space:

	if (subflow_req->mp_capable) {
		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
		opts->sndr_key =3D subflow_req->local_key;
		opts->rcvr_key =3D subflow_req->remote_key;  <=3D=3D delete this
		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;

The new value for TCPOLEN_MPTCP_MPC_SYNACK means it won't be sent as intend=
ed
by this change, but this line is now irrevelant.

Peter.


--===============1138536731376345650==--
