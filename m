Content-Type: multipart/mixed; boundary="===============0655208026662303413=="
MIME-Version: 1.0
From: James Morris <jmorris at namei.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/3] security: add const qualifier to
 struct sock in various places
Date: Fri, 04 Dec 2020 04:07:16 +1100
Message-ID: <alpine.LRH.2.21.2012040407080.9312@namei.org>
In-Reply-To: 20201202112848.46bf4ea6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 7026

--===============0655208026662303413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Dec 2020, Jakub Kicinski wrote:

> On Mon, 30 Nov 2020 16:36:29 +0100 Florian Westphal wrote:
> > A followup change to tcp_request_sock_op would have to drop the 'const'
> > qualifier from the 'route_req' function as the
> > 'security_inet_conn_request' call is moved there - and that function
> > expects a 'struct sock *'.
> > =

> > However, it turns out its also possible to add a const qualifier to
> > security_inet_conn_request instead.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  The code churn is unfortunate.  Alternative would be to change
> >  the function signature of ->route_req:
> >  struct dst_entry *(*route_req)(struct sock *sk, ...
> >  [ i.e., drop 'const' ].  Thoughts?
> =

> Security folks - is this okay to merge into net-next?
> =

> We can put it on a branch and pull into both trees if the risk =

> of conflicts is high.


Acked-by: James Morris <jamorris(a)linux.microsoft.com>

> =

> > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > index 28f23b341c1c..cd23355d2271 100644
> > --- a/include/linux/lsm_audit.h
> > +++ b/include/linux/lsm_audit.h
> > @@ -26,7 +26,7 @@
> >  =

> >  struct lsm_network_audit {
> >  	int netif;
> > -	struct sock *sk;
> > +	const struct sock *sk;
> >  	u16 family;
> >  	__be16 dport;
> >  	__be16 sport;
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 32a940117e7a..acc0494cceba 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -301,7 +301,7 @@ LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, con=
st struct sock *sk,
> >  	 struct sock *newsk)
> >  LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, struct sock *sk, u32 *secid)
> >  LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socke=
t *parent)
> > -LSM_HOOK(int, 0, inet_conn_request, struct sock *sk, struct sk_buff *s=
kb,
> > +LSM_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_b=
uff *skb,
> >  	 struct request_sock *req)
> >  LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
> >  	 const struct request_sock *req)
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index bc2725491560..0df62735651b 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -1358,7 +1358,7 @@ void security_sk_clone(const struct sock *sk, str=
uct sock *newsk);
> >  void security_sk_classify_flow(struct sock *sk, struct flowi *fl);
> >  void security_req_classify_flow(const struct request_sock *req, struct=
 flowi *fl);
> >  void security_sock_graft(struct sock*sk, struct socket *parent);
> > -int security_inet_conn_request(struct sock *sk,
> > +int security_inet_conn_request(const struct sock *sk,
> >  			struct sk_buff *skb, struct request_sock *req);
> >  void security_inet_csk_clone(struct sock *newsk,
> >  			const struct request_sock *req);
> > @@ -1519,7 +1519,7 @@ static inline void security_sock_graft(struct soc=
k *sk, struct socket *parent)
> >  {
> >  }
> >  =

> > -static inline int security_inet_conn_request(struct sock *sk,
> > +static inline int security_inet_conn_request(const struct sock *sk,
> >  			struct sk_buff *skb, struct request_sock *req)
> >  {
> >  	return 0;
> > diff --git a/security/apparmor/include/net.h b/security/apparmor/includ=
e/net.h
> > index 2431c011800d..aadb4b29fb66 100644
> > --- a/security/apparmor/include/net.h
> > +++ b/security/apparmor/include/net.h
> > @@ -107,6 +107,6 @@ int aa_sock_file_perm(struct aa_label *label, const=
 char *op, u32 request,
> >  		      struct socket *sock);
> >  =

> >  int apparmor_secmark_check(struct aa_label *label, char *op, u32 reque=
st,
> > -			   u32 secid, struct sock *sk);
> > +			   u32 secid, const struct sock *sk);
> >  =

> >  #endif /* __AA_NET_H */
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index ffeaee5ed968..1b0aba8eb723 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -1147,7 +1147,7 @@ static void apparmor_sock_graft(struct sock *sk, =
struct socket *parent)
> >  }
> >  =

> >  #ifdef CONFIG_NETWORK_SECMARK
> > -static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff =
*skb,
> > +static int apparmor_inet_conn_request(const struct sock *sk, struct sk=
_buff *skb,
> >  				      struct request_sock *req)
> >  {
> >  	struct aa_sk_ctx *ctx =3D SK_CTX(sk);
> > diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> > index fa0e85568450..e0c1b50d6edd 100644
> > --- a/security/apparmor/net.c
> > +++ b/security/apparmor/net.c
> > @@ -211,7 +211,7 @@ static int apparmor_secmark_init(struct aa_secmark =
*secmark)
> >  }
> >  =

> >  static int aa_secmark_perm(struct aa_profile *profile, u32 request, u3=
2 secid,
> > -			   struct common_audit_data *sa, struct sock *sk)
> > +			   struct common_audit_data *sa)
> >  {
> >  	int i, ret;
> >  	struct aa_perms perms =3D { };
> > @@ -244,13 +244,13 @@ static int aa_secmark_perm(struct aa_profile *pro=
file, u32 request, u32 secid,
> >  }
> >  =

> >  int apparmor_secmark_check(struct aa_label *label, char *op, u32 reque=
st,
> > -			   u32 secid, struct sock *sk)
> > +			   u32 secid, const struct sock *sk)
> >  {
> >  	struct aa_profile *profile;
> >  	DEFINE_AUDIT_SK(sa, op, sk);
> >  =

> >  	return fn_for_each_confined(label, profile,
> >  				    aa_secmark_perm(profile, request, secid,
> > -						    &sa, sk));
> > +						    &sa));
> >  }
> >  #endif
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 53d0d183db8f..078f9cdcd7f5 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -183,7 +183,7 @@ int ipv6_skb_to_auditdata(struct sk_buff *skb,
> >  =

> >  =

> >  static inline void print_ipv6_addr(struct audit_buffer *ab,
> > -				   struct in6_addr *addr, __be16 port,
> > +				   const struct in6_addr *addr, __be16 port,
> >  				   char *name1, char *name2)
> >  {
> >  	if (!ipv6_addr_any(addr))
> > @@ -322,7 +322,7 @@ static void dump_common_audit_data(struct audit_buf=
fer *ab,
> >  	}
> >  	case LSM_AUDIT_DATA_NET:
> >  		if (a->u.net->sk) {
> > -			struct sock *sk =3D a->u.net->sk;
> > +			const struct sock *sk =3D a->u.net->sk;
> >  			struct unix_sock *u;
> >  			struct unix_address *addr;
> >  			int len =3D 0;
> > diff --git a/security/security.c b/security/security.c
> > index a28045dc9e7f..6509f95d203f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2225,7 +2225,7 @@ void security_sock_graft(struct sock *sk, struct =
socket *parent)
> >  }
> >  EXPORT_SYMBOL(security_sock_graft);
> >  =

> > -int security_inet_conn_request(struct sock *sk,
> > +int security_inet_conn_request(const struct sock *sk,
> >  			struct sk_buff *skb, struct request_sock *req)
> >  {
> >  	return call_int_hook(inet_conn_request, 0, sk, skb, req);
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658..6fa593006802 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -5355,7 +5355,7 @@ static void selinux_sctp_sk_clone(struct sctp_end=
point *ep, struct sock *sk,
> >  	selinux_netlbl_sctp_sk_clone(sk, newsk);
> >  }
> >  =

> > -static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *=
skb,
> > +static int selinux_inet_conn_request(const struct sock *sk, struct sk_=
buff *skb,
> >  				     struct request_sock *req)
> >  {
> >  	struct sk_security_struct *sksec =3D sk->sk_security;
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 5c90b9fa4d40..3a62d6aa74a6 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -3864,7 +3864,7 @@ static inline struct smack_known *smack_from_skb(=
struct sk_buff *skb)
> >   *
> >   * Returns smack_known of the IP options or NULL if that won't work.
> >   */
> > -static struct smack_known *smack_from_netlbl(struct sock *sk, u16 fami=
ly,
> > +static struct smack_known *smack_from_netlbl(const struct sock *sk, u1=
6 family,
> >  					     struct sk_buff *skb)
> >  {
> >  	struct netlbl_lsm_secattr secattr;
> > @@ -4114,7 +4114,7 @@ static void smack_sock_graft(struct sock *sk, str=
uct socket *parent)
> >   * Returns 0 if a task with the packet label could write to
> >   * the socket, otherwise an error code
> >   */
> > -static int smack_inet_conn_request(struct sock *sk, struct sk_buff *sk=
b,
> > +static int smack_inet_conn_request(const struct sock *sk, struct sk_bu=
ff *skb,
> >  				   struct request_sock *req)
> >  {
> >  	u16 family =3D sk->sk_family;
> =


-- =

James Morris
<jmorris(a)namei.org>

--===============0655208026662303413==--
