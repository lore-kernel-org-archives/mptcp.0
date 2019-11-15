Content-Type: multipart/mixed; boundary="===============5447739214621738722=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Basic single-subflow DATA_FIN
Date: Fri, 15 Nov 2019 11:27:53 -0800
Message-ID: <alpine.OSX.2.21.1911151037580.57916@chiulam-mobl.amr.corp.intel.com>
In-Reply-To: 2431e83e-6184-95e8-295a-3baa7b629126@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2554

--===============5447739214621738722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 15 Nov 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 14/11/2019 07:06, Mat Martineau wrote:
>> Send a DATA_FIN along with any subflow TCP FIN flag.
>> =

>> This seems to expose a bug in either the receive side disconnect
>> handling or the mptcp_connect test program. The self test has
>> intermittent problems with the receive temp file being truncated.
>> =

>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>
> Thank you for the patch!
>
>> ---
>> =

>> I've tested this commit when applied to the end of the export branch,
>> but I have not yet applied or tested it earlier in the history with the
>> "initial feature set" patches.
>
> Good point :)
>
>> net/mptcp/options.c | 38 +++++++++++++++++++++++++++++++++++---
>>   net/mptcp/subflow.c | 32 ++++++++++++++++++--------------
>>   2 files changed, 53 insertions(+), 17 deletions(-)
>> =

>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 9a18a3670cdf..79890b96afeb 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -384,18 +384,47 @@ static bool mptcp_established_options_mp(struct so=
ck =

>> *sk, unsigned int *size,
>>   	return false;
>>   }
>>   +static void mptcp_write_data_fin(struct mptcp_subflow_context *subflo=
w,
>> +				 struct mptcp_ext *ext)
>> +{
>> +	WARN_ONCE(!subflow->conn, "MPTCP: Missing MPTCP socket information");
>
> I guess that if you think the WARN is needed, maybe safer to also return =

> earlier, not to use "subflow->conn" later on if !ext->use_map.

I had this included as a paranoid debugging check for development. I =

should have dropped it, and looking around at other code it looks like =

subflow->conn is always set.

>
>> +	/* Only send DATA_FIN if all data has been sent or this is the last
>> +	 * mapping.
>
> Maybe it is just me but the comment looks confusing when placed here: for=
 me, =

> starting it with "Only" means that we have a "if" statement just after.

Good point, this carried over from some code that did have that 'if'. Will =

fix.

>
>> +	 */
>> +	ext->data_fin =3D 1;
>> +
>> +	if (!ext->use_map) {
>> +		ext->use_map =3D 1;
>> +		ext->dsn64 =3D 1;
>> +		ext->data_seq =3D mptcp_sk(subflow->conn)->write_seq;
>> +		ext->subflow_seq =3D 0;
>> +		ext->data_len =3D 1;
>> +	} else {
>> +		ext->data_len++;
>> +	}
>> +}
>> +
>>   static bool mptcp_established_options_dss(struct sock *sk, struct sk_b=
uff =

>> *skb,
>>   					  unsigned int *size,
>>   					  unsigned int remaining,
>>   					  struct mptcp_out_options *opts)
>>   {
>> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>>   	unsigned int dss_size =3D 0;
>>   	struct mptcp_ext *mpext;
>>   	unsigned int ack_size;
>> +	u8 tcp_fin;
>
> Detail: could we use a "boolean" type here?

I did consider that when writing it. With bool, I'd want to use "tcp_fin =
=3D =

!!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)" below. It seemed cleaner to =

match the type of tcp_flags and skip the !! stuff.

(it does happen that TCPHDR_FIN is 0x01 so there's not much difference to =

the compiler)

>
>>   -	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
>> +	if (skb) {
>> +		mpext =3D mptcp_get_ext(skb);
>> +		tcp_fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
>> +	} else {
>> +		mpext =3D NULL;
>> +		tcp_fin =3D 0;
>> +	}
>>   -	if (!skb || (mpext && mpext->use_map)) {
>> +	if (!skb || (mpext && mpext->use_map) || tcp_fin) {
>>   		unsigned int map_size;
>>     		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
>> @@ -405,6 +434,9 @@ static bool mptcp_established_options_dss(struct soc=
k =

>> *sk, struct sk_buff *skb,
>>   			dss_size =3D map_size;
>>   			if (mpext)
>>   				opts->ext_copy =3D *mpext;
>> +
>> +			if (skb && tcp_fin)
>
> As discussed at the meeting yesterday, may you also check that it is the =
last =

> subflow please?

Yes - although I think determining the "last subflow" is more complicated =

than looking at the length of the conn list. We don't want DATA_FIN if one =

subflow is closing and others are staying open, but DATA_FIN is desired of =

all subflows are closing at the same time.

>
>> +				mptcp_write_data_fin(subflow, =

>> &opts->ext_copy);
>>   		} else {
>>   			opts->ext_copy.use_map =3D 0;
>>   			WARN_ONCE(1, "MPTCP: Map dropped");
>> @@ -422,7 +454,7 @@ static bool mptcp_established_options_dss(struct soc=
k =

>> *sk, struct sk_buff *skb,
>>     		dss_size +=3D ack_size;
>>   -		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>> +		msk =3D mptcp_sk(subflow->conn);
>>   		if (msk) {
>>   			opts->ext_copy.data_ack =3D msk->ack_seq;
>>   		} else {
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index ff38d54392cd..f6f4dbf2dbab 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -422,6 +422,7 @@ static enum mapping_status get_mapping_status(struct =

>> sock *ssk)
>>   	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>>   	struct mptcp_ext *mpext;
>>   	struct sk_buff *skb;
>> +	u16 data_len;
>>   	u64 map_seq;
>>     	skb =3D skb_peek(&ssk->sk_receive_queue);
>> @@ -446,26 +447,29 @@ static enum mapping_status get_mapping_status(stru=
ct =

>> sock *ssk)
>>     		if (!subflow->map_valid)
>>   			return MAPPING_INVALID;
>> +
>>   		goto validate_seq;
>>   	}
>>   -	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_=
seq,
>> -		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
>> +	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
>> +		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
>> +		 mpext->data_len, mpext->data_fin);
>>   -	if (mpext->data_len =3D=3D 0) {
>> +	data_len =3D mpext->data_len;
>> +	if (data_len =3D=3D 0) {
>>   		pr_err("Infinite mapping not handled");
>>   		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
>>   		return MAPPING_INVALID;
>> -	} else if (mpext->subflow_seq =3D=3D 0 &&
>> -		   mpext->data_fin =3D=3D 1) {
>> -		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
>> -			return false;
>> +	}
>>   -		/* do not try hard to handle this any better, till we have
>> -		 * real data_fin support
>> -		 */
>> -		pr_debug("DATA_FIN with no payload");
>> -		return MAPPING_DATA_FIN;
>> +	if (mpext->data_fin =3D=3D 1) {
>> +		if (data_len =3D=3D 1) {
>> +			pr_debug("DATA_FIN with no payload"); > + =

>> return MAPPING_DATA_FIN;> +		}
>> +
>> +		/* Adjust for DATA_FIN using 1 byte of sequence space */
>> +		data_len--;
>
> Is it because here we cannot add the DATA_FIN bit yet, still more data to =

> send?
>

This is on the receive side to adjust the mapping to reflect the actual =

data payload that is in the skbs. The DATA_FIN received from the peer =

consumes a byte of MPTCP-level sequence space even though there is no =

corresponding skb data payload for the reassembly code to look for.

When DATA_FIN is sent in a packet with data payload, the DSS =

mapping is extended by 1 in mptcp_write_data_fin() (look for =

"ext->data_len++" above), so this line of code is restoring the original =

mapping for reassembly purposes.

--
Mat Martineau
Intel
--===============5447739214621738722==--
