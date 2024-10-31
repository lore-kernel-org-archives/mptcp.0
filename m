Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630014B08C
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361353; cv=none; b=ijUk/NM6luf/LFhKRehCBledYCWEQYnmvT1tmS2BnGRZVXBgkjOrn3kry8ymli7exEgRDumOL+7olhrlQnlLQOljV/OmB4hKBdTUG0RS2pEt6cEjr+Oz4fFFVujjpd5rVdfjUdgXxXcRnpiK3yEsHJz7TseqBzLriqLVE7nD93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361353; c=relaxed/simple;
	bh=G/bfYZW70geHFuDGU9mJluMK5imaYirrcnkMVJV5MHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZXCb3jXycxPDXRYPGvPFGZWytd+x7a1I242mA5o3r9dASTZ2FfcnyR84OEVwQLH+FtABvZdo7Zvzhee6HHHxlSWDQc7bb518cDNabKBIMgVjQukXUDhbVPde7W2aDwqE/DAGRjyRBb+u9F8HEEv1aFciwd+zUOcPG0aalM2Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmvogcEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmvogcEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1386C4CEC3;
	Thu, 31 Oct 2024 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361352;
	bh=G/bfYZW70geHFuDGU9mJluMK5imaYirrcnkMVJV5MHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pmvogcEN4LFSoaQ8S+iEAorkwjpKZ9PhkopTJT7QQXSYEBo/ARJHwh6udPxUA7Trv
	 iPct+JqqtJX6s+oI8g3BH/2cHClGE1gdCxIRwpDrQWFyMP1fa7h0jmK8Wj++3r40x5
	 sSj8d8qe70C9jMBqwCFizbu6HDi8CLDwX7nuM4juWREob/osW4R7zWMFuEPV7MiNJR
	 U8w+lZSPLOUvCeWgvF5tRKtLPAKfquqMQ4wnYSS5Mo39a8qHLLQ7UGEn3DhuT+Xobh
	 Bc6YjQDOh4jXk+ixNoT3vOGhn+0+gw9QcBSUy/e5c8n/G0LIuUSo71VV3Viw+8SEg+
	 J6sA0skxeoN4A==
Message-ID: <dcf330f030ea45dbd06058e95de119bc94e81e3d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 03/36] mptcp: add mptcp_for_each_address
 macros
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 31 Oct 2024 15:55:49 +0800
In-Reply-To: <293210ee-ef7c-4ad7-a46d-82beb1dec193@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn>
	 <293210ee-ef7c-4ad7-a46d-82beb1dec193@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-10-30 at 19:20 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Similar to mptcp_for_each_subflow() and
> > mptcp_for_each_subflow_safe()
> > macros, this patch adds two new macros mptcp_for_each_address() and
> > mptcp_for_each_address_safe() to iterate over the address entries
> > on
> > userspace_pm_local_addr_list of the mptcp socket.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_userspace.c | 12 ++++++------
> >  net/mptcp/protocol.h     |  5 +++++
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 2cceded3a83a..00a7f9dd90cf 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -41,7 +41,7 @@ static int
> > mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> >  	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> >  
> >  	spin_lock_bh(&msk->pm.lock);
> > -	list_for_each_entry(e, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address(msk, e) {
> >  		addr_match = mptcp_addresses_equal(&e->addr,
> > &entry->addr, true);
> >  		if (addr_match && entry->addr.id == 0 && needs_id)
> >  			entry->addr.id = e->addr.id;
> > @@ -92,7 +92,7 @@ static int
> > mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> >  {
> >  	struct mptcp_pm_addr_entry *entry, *tmp;
> >  
> > -	list_for_each_entry_safe(entry, tmp, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address_safe(msk, entry, tmp) {
> >  		if (mptcp_addresses_equal(&entry->addr, &addr-
> > >addr, false)) {
> >  			/* TODO: a refcount is needed because the
> > entry can
> >  			 * be used multiple times (e.g. fullmesh
> > mode).
> > @@ -112,7 +112,7 @@ mptcp_userspace_pm_lookup_addr_by_id(struct
> > mptcp_sock *msk, unsigned int id)
> >  {
> >  	struct mptcp_pm_addr_entry *entry;
> >  
> > -	list_for_each_entry(entry, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address(msk, entry) {
> >  		if (entry->addr.id == id)
> >  			return entry;
> >  	}
> > @@ -127,7 +127,7 @@ int mptcp_userspace_pm_get_local_id(struct
> > mptcp_sock *msk,
> >  			     inet_sk((struct sock *)msk))-
> > >inet_sport;
> >  
> >  	spin_lock_bh(&msk->pm.lock);
> > -	list_for_each_entry(e, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address(msk, e) {
> >  		if (mptcp_addresses_equal(&e->addr, skc, false)) {
> >  			entry = e;
> >  			break;
> > @@ -155,7 +155,7 @@ bool mptcp_userspace_pm_is_backup(struct
> > mptcp_sock *msk,
> >  	bool backup = false;
> >  
> >  	spin_lock_bh(&msk->pm.lock);
> > -	list_for_each_entry(entry, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address(msk, entry) {
> >  		if (mptcp_addresses_equal(&entry->addr, skc,
> > false)) {
> >  			backup = !!(entry->flags &
> > MPTCP_PM_ADDR_FLAG_BACKUP);
> >  			break;
> > @@ -642,7 +642,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff
> > *msg,
> >  
> >  	lock_sock(sk);
> >  	spin_lock_bh(&msk->pm.lock);
> > -	list_for_each_entry(entry, &msk-
> > >pm.userspace_pm_local_addr_list, list) {
> > +	mptcp_for_each_address(msk, entry) {
> >  		if (test_bit(entry->addr.id, bitmap->map))
> >  			continue;
> >  
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index b4c72a73594f..ce3b12778b3f 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -354,6 +354,11 @@ struct mptcp_sock {
> >  #define mptcp_for_each_subflow_safe(__msk, __subflow,
> > __tmp)			\
> >  	list_for_each_entry_safe(__subflow, __tmp, &((__msk)-
> > >conn_list), node)
> >  
> > +#define mptcp_for_each_address(__msk, __entry)			\
> > +	list_for_each_entry(__entry, &((__msk)-
> > >pm.userspace_pm_local_addr_list), list)
> > +#define mptcp_for_each_address_safe(__msk, __entry,
> > __tmp)			\
> > +	list_for_each_entry_safe(__entry, __tmp, &((__msk)-
> > >pm.userspace_pm_local_addr_list), list)
> 
> If it is specific to the userspace PM, maybe best to declare them in
> pm_userspace.c, no?
> 
> Also, the name is very generic for something so specific. Maybe:
> 
>   mptcp_for_each_pm_userspace_local_addr(_safe)
> 
> Otherwise, if we see "mptcp_for_each_address(msk, entry)" in the
> code,
> it is really not clear what you are looking at I think, no?

Good idea! I moved it into pm_userspace.c and renamed it as
mptcp_for_each_userspace_pm_addr.

Furthermore, I renamed mptcp_address bpf_iter in another set "add
mptcp_address bpf_iter" as mptcp_userspace_pm_addr bpf_iter to keep it
consistent with this patch.

Thanks,
-Geliang

> 
> > +
> >  extern struct genl_family mptcp_genl_family;
> >  
> >  static inline void msk_owned_by_me(const struct mptcp_sock *msk)
> 
> Cheers,
> Matt

