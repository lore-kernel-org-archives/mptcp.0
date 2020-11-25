Content-Type: multipart/mixed; boundary="===============5915229914103833896=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 8/9] mptcp: add the mibs for
 ADD_ADDR with port
Date: Wed, 25 Nov 2020 11:03:22 +0100
Message-ID: <f58890ee973debd06bdc7b823c5be75249641974.camel@redhat.com>
In-Reply-To: b04b5fa61f8b4e662ddd67208416b5473602a928.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6923

--===============5915229914103833896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> This patch added the mibs for ADD_ADDR with port:
> =

> MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
> number. MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX,
> for receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number
> which is different from the msk's port number.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/mib.c     | 4 ++++
>  net/mptcp/mib.h     | 4 ++++
>  net/mptcp/options.c | 4 ++++
>  net/mptcp/subflow.c | 3 +++
>  4 files changed, 15 insertions(+)
> =

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 84d119436b22..5e8f7827cfe0 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -29,6 +29,10 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>  	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
>  	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
>  	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
> +	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
> +	SNMP_MIB_ITEM("PortSynRx", MPTCP_MIB_PORTSYNRX),
> +	SNMP_MIB_ITEM("PortSynAckRx", MPTCP_MIB_PORTSYNACKRX),
> +	SNMP_MIB_ITEM("PortAckRx", MPTCP_MIB_PORTACKRX),
>  	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
>  	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
>  	SNMP_MIB_SENTINEL
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 47bcecce1106..b762941d492f 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -22,6 +22,10 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
>  	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
>  	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
> +	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with port */
> +	MPTCP_MIB_PORTSYNRX,		/* Received a SYN + MP_JOIN with port */
> +	MPTCP_MIB_PORTSYNACKRX,		/* Received a SYN/ACK + MP_JOIN with port */
> +	MPTCP_MIB_PORTACKRX,		/* Received an ACK + MP_JOIN with port */
>  	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
>  	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
>  	__MPTCP_MIB_MAX
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d1b4c5d208a9..9db824b1ed33 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -959,6 +959,10 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
>  			mptcp_pm_del_add_timer(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
>  		}
> +
> +		if (mp_opt.port)
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> +
>  		mp_opt.add_addr =3D 0;
>  	}
>  =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index cb72327c006a..6193e53d4af1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -196,6 +196,7 @@ static void subflow_init_req(struct request_sock *req,
>  				subflow_req->mp_join =3D 0;

We likely want to increment some 'bad port' MIB counter in case of
mismatch.

@Christoph: looks like mptcp.org does not have MIBs for these things,
any plan to add them? any suggestions on relevant names/things to
track?

Thanks!

Paolo

--===============5915229914103833896==--
