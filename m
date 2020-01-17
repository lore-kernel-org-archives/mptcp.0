Content-Type: multipart/mixed; boundary="===============1644852856841324913=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Re-factor expand_ack
Date: Fri, 17 Jan 2020 09:22:17 -0800
Message-ID: <alpine.OSX.2.21.2001170909370.60719@mjmartin-mac01.local>
In-Reply-To: 20200116011324.3253-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3403

--===============1644852856841324913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 15 Jan 2020, Peter Krystad wrote:

> Modify this commit to handle separately-stored 32-bit data acks.
>
> squashto: update per unacked sequence on pkt reception
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> net/mptcp/options.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bd1c3ba134ae..6ad0cdfa6de2 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -674,15 +674,16 @@ static bool check_fourth_ack(struct mptcp_subflow_c=
ontext *subflow,
> 	return true;
> }
>
> -static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
> +static u64 expand_ack(u64 old_ack, u32 cur_ack32)
> {
> -	u32 old_ack32, cur_ack32;
> -
> -	if (use_64bit)
> -		return cur_ack;
> +	u32 old_ack32;
> +	u64 cur_ack;
>
> +	/* avoid ack expansion on update conflict, to reduce the risk of
> +	 * wrongly expanding to a future ack sequence number, which is way
> +	 * more dangerous than missing an ack
> +	 */

I think this comment belongs in the original function - there's no =

conflict detection going on in this function.

> 	old_ack32 =3D (u32)old_ack;
> -	cur_ack32 =3D (u32)cur_ack;
> 	cur_ack =3D (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
> 	if (unlikely(before(cur_ack32, old_ack32)))
> 		return cur_ack + (1LL << 32);
> @@ -695,11 +696,10 @@ static void update_una(struct mptcp_sock *msk,
> 	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);
> 	u64 write_seq =3D READ_ONCE(msk->write_seq);
>
> -	/* avoid ack expansion on update conflict, to reduce the risk of
> -	 * wrongly expanding to a future ack sequence number, which is way
> -	 * more dangerous than missing an ack
> -	 */

I have to admit this comment does seem out of place here too. In an =

earlier version, the comment was closer to the while loop (see =

https://www.spinics.net/lists/netdev/msg602279.html )

> -	new_snd_una =3D expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64=
);
> +	if (mp_opt->ack64)
> +		new_snd_una =3D mp_opt->data_ack;
> +	else
> +		new_snd_una =3D expand_ack(old_snd_una, (u32)mp_opt->data_ack);
>
> 	/* ACK for data not even sent yet? Ignore. */
> 	if (after64(new_snd_una, write_seq))
> -- =

> 2.17.2

--
Mat Martineau
Intel
--===============1644852856841324913==--
