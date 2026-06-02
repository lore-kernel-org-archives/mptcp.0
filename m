Received: from outbound.qs.icloud.com (qs-2001l-snip4-8.eps.apple.com [57.103.87.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFE191F91
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371995; cv=none; b=Ujlg/injOKtiqRBJh0/KfsrWm1+qXkYSBPSrXUI4N8Yow795+YiKIk49B9JnnxHGyyu6L/bjWHqB7AsoSCHnQAs00oWhOyCQ0DSuuNthDcUTL1b3dLysAURvr5l6sFenQsQqKyeNEGHndiWsV/9nA9lweshcI8kFfvUJxLKrLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371995; c=relaxed/simple;
	bh=IX3JgdAYzwhCmL0leutrp8yuQrB2dazfHN22Y/uDUbI=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:Cc:To; b=EvfNQ+Gw3yFPfErE+Hm3tl++t2KKkegqpzL2XBV3f7HAtLHdlg1xLoeuqULsC9Gpor9sjj/RsLh7WdIBqGYRU7F/B9x+SEgtYgGIKmQ5gJmB8Ffpr4nZhMrF0y4bEgMyNX8UMcDhI0avu9nZx/oVBKDjEypxTD8TpRTWVT9S9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yYO29rJx; arc=none smtp.client-ip=57.103.87.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yYO29rJx"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id E436D1800A86;
	Tue, 02 Jun 2026 03:46:30 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhACkMFWwFeCEgFQwZeAFBcHA4KUgpAGF4NVh9FDkAfeRFQAVgeVl5aF15NUQ8PGVoUXBhTRVEfVFhBDgpfEhhcFFxQWB5GElYNXQkZGkFeUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKV3FADE8FWnIvH0EKOQZAAyhxRBQ5clQDRgpGfTwAKQBZdDIMTHMEVAddBV1WUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1780371993; x=1782963993; bh=4pcLwhKdhbk4X6WzDkx3VGMpDVpS9uP4OApM9ZGoVfY=; h=Content-Type:From:Mime-Version:Date:Message-Id:To:x-icloud-hme; b=yYO29rJxZbjTZeD6F7d5eGLe9/7+bBFfYPeJVqz3d91QW+9KQAG7vNZOmHNGB/M0Gvl0tAP0fd4b+EK52iu3OBDQlug58Vc3qsfW27xKjV0fpGNO/2hs7fWTWPa4kUJjZBSFGylQELLl5aQcc/eIxZhDCPQZfuSIksroiFq1tZw3vufgIhVt/sGxfqKCE2rY4nHpI0Ndv4FhfAS6rPAIkGHHFn8p9WJWhPFdtC9iMExaRTLimRPRObBLsFc1rcfH3faV4hvaKQBXJDIsu34I6MSXsBR/6bM58uPRhDtjzib3O5P8bQdWTXWavcWbmN7ifncGYu7B/tuuks+ZmQic5w==
mail-alias-created-date: 1755741129474
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id CCE0C180009D;
	Tue, 02 Jun 2026 03:46:29 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Chris Guerrero <gearhguerrero@icloud.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Date: Mon, 1 Jun 2026 21:46:28 -0600
Message-Id: <C05767ED-13A5-4CC4-AA94-86DD3D72FB54@icloud.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
 Gang Yan <yangang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-ORIG-GUID: -f6Y-MNAPGyTn1fD_g7IPsopKG9rCht_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzMSBTYWx0ZWRfXx5WK+Ayw+Omd
 h2rAu9r+4BLp3/HZIBX5mhEe8Iko5CYut4gdvlDKzKkwIwW9kcB8BOMVc8kod3Kz+FEp4TJchKe
 anjmn1omAKt8bao5dQbsbbE2ybwkYb+r9yAkxiOtjrh9h5IcVrEDHwBbPB3Wu+AGi2ylVBdoA/4
 aDqt9sYYSdC/m9C1LSqcOytsumdXBm+pJ+j3KkRnBjB6EG9Lr+DVMC4pg52TXl/MuplWDXfWGoF
 Vnu8qfBhcHAPxW01niqD1qUX9m2Dx7wtXmmqMEdClK9TdWvtswo/02zBRsclsl4xVuPe7bpEVQ4
 R2D35Bxr4/VI6tW0qJ3o9igKI0lhPoczzy7P5aJUZNDSJn4VQud6NrhZmC2CT4=
X-Proofpoint-GUID: -f6Y-MNAPGyTn1fD_g7IPsopKG9rCht_
X-Authority-Info-Out: v=2.4 cv=aKn9aL9m c=1 sm=1 tr=0 ts=6a1e5217
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=x7bEGLp0ZPQA:10 a=8IWW5uUoFxMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=46fsmK_P8LEJzEmltdgA:9
 a=QEXdDO2ut3YA:10


> On Jun 1, 2026, at 8:36=E2=80=AFPM, Geliang Tang <geliang@kernel.org> wrot=
e:
>=20
> =EF=BB=BFFrom: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> To extend MPTCP support based on TCP TLS, a tls_prot_ops structure has
> been introduced for TLS, encapsulating TCP-specific helpers within this
> structure.
>=20
> Add registering, validating and finding functions for this structure to
> add, validate and find a tls_prot_ops on the global list tls_prot_ops_list=
.
>=20
> Register TCP-specific structure tls_tcp_ops in tls_register().
>=20
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> include/net/tls.h  |  22 ++++++++++
> net/tls/tls_main.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 127 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 7ff4d4566d41..e13894c054ad 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -220,6 +220,28 @@ struct tls_prot_info {
>    u16 tail_size;
> };
>=20
> +struct tls_prot_ops {
> +    struct module        *owner;
> +    int            protocol;
> +    struct list_head    list;
> +
> +    int (*inq)(struct sock *sk);
> +    int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg,
> +                  size_t size);
> +    struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
> +    bool (*lock_is_held)(struct sock *sk);
> +    int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
> +             sk_read_actor_t recv_actor);
> +    void (*read_done)(struct sock *sk, size_t len);
> +    u32 (*get_skb_seq)(struct sk_buff *skb);
> +    int (*skb_copy_bits)(const struct sk_buff *skb, int offset,
> +                 void *to, int len);
> +    __poll_t (*poll)(struct file *file, struct socket *sock,
> +             struct poll_table_struct *wait);
> +    bool (*epollin_ready)(const struct sock *sk);
> +    void (*check_app_limited)(struct sock *sk);
> +};
> +
> struct tls_prot {
>    struct rcu_head            rcu;
>    refcount_t            refcnt;
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 62426f478ce0..8fe9529ba4e8 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -120,6 +120,7 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypt=
o_info_aria_gcm_128);
> CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256)=
;
>=20
> static LIST_HEAD(tls_prot_list);
> +static LIST_HEAD(tls_prot_ops_list);
> static DEFINE_SPINLOCK(tls_prot_lock);
> static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG]=
,
>             const struct proto *base);
> @@ -161,6 +162,22 @@ static void tls_prot_cleanup(void)
>    rcu_barrier();
> }
>=20
> +static struct tls_prot_ops *tls_prot_ops_find(int protocol)
> +{
> +    struct tls_prot_ops *ops, *ret =3D NULL;
> +
> +    rcu_read_lock();
> +    list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
> +        if (ops->protocol =3D=3D protocol) {
> +            ret =3D ops;
> +            break;
> +        }
> +    }
> +    rcu_read_unlock();
> +
> +    return ret;
> +}
> +
> void update_sk_prot(struct sock *sk, struct tls_context *ctx)
> {
>    struct tls_prot *prot =3D ctx->prot;
> @@ -1315,6 +1332,86 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mo=
stly =3D {
>    .get_info_size        =3D tls_get_info_size,
> };
>=20
> +static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
> +{
> +    if (!ops->inq || !ops->sendmsg_locked ||
> +        !ops->recv_skb || !ops->lock_is_held ||
> +        !ops->read_sock || !ops->read_done ||
> +        !ops->get_skb_seq || !ops->skb_copy_bits ||
> +        !ops->poll || !ops->epollin_ready ||
> +        !ops->check_app_limited) {
> +        pr_err("%d does not implement required ops\n", ops->protocol);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tls_register_prot_ops(struct tls_prot_ops *ops)
> +{
> +    int ret;
> +
> +    ret =3D tls_validate_prot_ops(ops);
> +    if (ret)
> +        return ret;
> +
> +    spin_lock_bh(&tls_prot_lock);
> +    if (tls_prot_ops_find(ops->protocol)) {
> +        spin_unlock_bh(&tls_prot_lock);
> +        return -EEXIST;
> +    }
> +
> +    list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
> +    spin_unlock_bh(&tls_prot_lock);
> +
> +    pr_debug("tls_prot_ops %d registered\n", ops->protocol);
> +    return 0;
> +}
> +
> +static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
> +{
> +    spin_lock_bh(&tls_prot_lock);
> +    list_del_rcu(&ops->list);
> +    spin_unlock_bh(&tls_prot_lock);
> +    synchronize_rcu();
> +}
> +
> +static struct sk_buff *tls_tcp_recv_skb(struct sock *sk, u32 *off)
> +{
> +    return tcp_recv_skb(sk, tcp_sk(sk)->copied_seq, off);
> +}
> +
> +static bool tls_tcp_lock_is_held(struct sock *sk)
> +{
> +    return sock_owned_by_user_nocheck(sk);
> +}
> +
> +static u32 tls_tcp_get_skb_seq(struct sk_buff *skb)
> +{
> +    return TCP_SKB_CB(skb)->seq;
> +}
> +
> +static bool tls_tcp_epollin_ready(const struct sock *sk)
> +{
> +    return tcp_epollin_ready(sk, INT_MAX);
> +}
> +
> +static struct tls_prot_ops tls_tcp_ops =3D {
> +    .owner            =3D THIS_MODULE,
> +    .protocol        =3D IPPROTO_TCP,
> +    .inq            =3D tcp_inq,
> +    .sendmsg_locked        =3D tcp_sendmsg_locked,
> +    .recv_skb        =3D tls_tcp_recv_skb,
> +    .lock_is_held        =3D tls_tcp_lock_is_held,
> +    .read_sock        =3D tcp_read_sock,
> +    .read_done        =3D tcp_read_done,
> +    .get_skb_seq        =3D tls_tcp_get_skb_seq,
> +    .skb_copy_bits        =3D skb_copy_bits,
> +    .poll            =3D tcp_poll,
> +    .epollin_ready        =3D tls_tcp_epollin_ready,
> +    .check_app_limited    =3D tcp_rate_check_app_limited,
> +};
> +
> static int __init tls_register(void)
> {
>    int err;
> @@ -1327,13 +1424,19 @@ static int __init tls_register(void)
>    if (err)
>        goto err_pernet;
>=20
> -    err =3D tls_device_init();
> +    err =3D tls_register_prot_ops(&tls_tcp_ops);
>    if (err)
>        goto err_strp;
>=20
> +    err =3D tls_device_init();
> +    if (err)
> +        goto err_ops;
> +
>    tcp_register_ulp(&tcp_tls_ulp_ops);
>=20
>    return 0;
> +err_ops:
> +    tls_unregister_prot_ops(&tls_tcp_ops);
> err_strp:
>    tls_strp_dev_exit();
> err_pernet:
> @@ -1344,6 +1447,7 @@ static int __init tls_register(void)
> static void __exit tls_unregister(void)
> {
>    tcp_unregister_ulp(&tcp_tls_ulp_ops);
> +    tls_unregister_prot_ops(&tls_tcp_ops);
>    tls_prot_cleanup();
>    tls_strp_dev_exit();
>    tls_device_cleanup();
> --
> 2.53.0
>=20
>=20
