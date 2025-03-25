Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007EA933
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876153; cv=none; b=lk8BdZxFqo/setBcDbFwf/4Y/ypbx/EUsSq6W7JNeCehGlkzlzaPGfDL1TxVGB/lUOBz9XjuuWlpiTyNJzat7qSPo61FJsrSjJHh5rMAEXVB0+2IrUwvHF0zeNGzG1unLT+QBaSU6HiRldBS7EEOOgb/vj/4viXrDFcKWJvxIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876153; c=relaxed/simple;
	bh=37qZnnXwJGNuarIXYklK0RjjK4gDBG5LdjOLavJJYtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1LigBQIt0rIQNqgpLwCO2uAppJoDADskkM5gq76ztK4wIXlajJW0vIFZM6+LIGYsnH2kGAihbi5JGwKbHleWh5VrR9mXx0PBtOOdqAyqOPy4LlBbbrgU+L3xUy9u1qp1ufQk7VU7q5bEHKj4IP133tj1VYdsV9fC3zZfSpkyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8GMxHu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8GMxHu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9E9C4CEE8;
	Tue, 25 Mar 2025 04:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742876153;
	bh=37qZnnXwJGNuarIXYklK0RjjK4gDBG5LdjOLavJJYtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p8GMxHu3xrpOmJC5m4xaUOHkR/HBdszvj8M5Y2B3t4opFic3cMXeVgLVw2TFPBijY
	 y3TXtioZlI6LL64bWwsMsenUUaEsMSQTEdp5nP46mPVRSpScNg4vDy0ZBZuEs1i/nR
	 yJtL7d3YvqA17loUO75eMFGygnQY3YL7yqqWCadLg3O13tSgdT1qHVAftrAiL8TFDh
	 jwYrmCmg7eoWVH3EJxt1q/imCuf8613h+6su21gNBCqo6Yl967Fa7EjG9x+XCBA9rT
	 F3tJNKO29m1eQb/Kf3GtohUdya+7E9qn7L23G/MjFrG9DNrBEI/AptnUf7uYbzT1Kl
	 nSUpWWt12K3QA==
Message-ID: <3e4cb2e62ff3fd6a0885f6314a618efb810940ab.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 1/4] bpf: Add mptcp path manager struct_ops
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 25 Mar 2025 12:15:49 +0800
In-Reply-To: <e78ddf1a-d3cf-4bc9-bcb9-bf901499e843@kernel.org>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
	 <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
	 <d5222db5-c6b0-4f3a-a4f5-d7b3a9932b19@kernel.org>
	 <fcb63d9a8c190c7cf57b87ad09378981ec89df66.camel@kernel.org>
	 <e78ddf1a-d3cf-4bc9-bcb9-bf901499e843@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-03-24 at 12:06 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/03/2025 11:43, Geliang Tang wrote:
> > On Mon, 2025-03-24 at 11:26 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 21/03/2025 02:49, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > This patch implements a new struct bpf_struct_ops for MPTCP BPF
> > > > path
> > > > manager: bpf_mptcp_pm_ops. Register and unregister the bpf path
> > > > manager
> > > > in .reg and .unreg.
> > > > 
> > > > Add write access for some fields of struct mptcp_sock and
> > > > struct
> > > > mptcp_pm_addr_entry in .btf_struct_access.
> > > > 
> > > > This MPTCP BPF path manager implementation is similar to BPF
> > > > TCP
> > > > CC. And
> > > > net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
> > > > 
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  net/mptcp/bpf.c | 259
> > > > +++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 258 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > > > index 2b0cfb57df8c..596574102b89 100644
> > > > --- a/net/mptcp/bpf.c
> > > > +++ b/net/mptcp/bpf.c
> > > 
> > > (...)
> > > 
> > > > +static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
> > > > +				       struct
> > > > mptcp_pm_addr_entry
> > > > *skc)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static bool __bpf_mptcp_pm_get_priority(struct mptcp_sock
> > > > *msk,
> > > > +					struct mptcp_addr_info
> > > > *skc)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static void __bpf_mptcp_pm_established(struct mptcp_sock *msk)
> > > > +{
> > > > +}
> > > > +
> > > > +static void __bpf_mptcp_pm_subflow_established(struct
> > > > mptcp_sock
> > > > *msk)
> > > > +{
> > > > +}
> > > > +
> > > > +static bool __bpf_mptcp_pm_allow_new_subflow(struct mptcp_sock
> > > > *msk)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static bool __bpf_mptcp_pm_accept_new_subflow(const struct
> > > > mptcp_sock *msk)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static bool __bpf_mptcp_pm_add_addr_echo(struct mptcp_sock
> > > > *msk,
> > > > +					 const struct
> > > > mptcp_addr_info *addr)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static int __bpf_mptcp_pm_add_addr_received(struct mptcp_sock
> > > > *msk,
> > > > +					    const struct
> > > > mptcp_addr_info *addr)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void __bpf_mptcp_pm_rm_addr_received(struct mptcp_sock
> > > > *msk)
> > > > +{
> > > > +}
> > > > +
> > > > +static void __bpf_mptcp_pm_init(struct mptcp_sock *msk)
> > > > +{
> > > > +}
> > > > +
> > > > +static void __bpf_mptcp_pm_release(struct mptcp_sock *msk)
> > > > +{
> > > > +}
> > > > +
> > > > +static struct mptcp_pm_ops __bpf_mptcp_pm_ops = {
> > > > +	.get_local_id		= __bpf_mptcp_pm_get_local_id,
> > > > +	.get_priority		= __bpf_mptcp_pm_get_priority,
> > > > +	.established		= __bpf_mptcp_pm_established,
> > > > +	.subflow_established	=
> > > > __bpf_mptcp_pm_subflow_established,
> > > > +	.allow_new_subflow      =
> > > > __bpf_mptcp_pm_allow_new_subflow,
> > > > +	.accept_new_subflow     =
> > > > __bpf_mptcp_pm_accept_new_subflow,
> > > > +	.add_addr_echo		=
> > > > __bpf_mptcp_pm_add_addr_echo,
> > > > +	.add_addr_received	=
> > > > __bpf_mptcp_pm_add_addr_received,
> > > > +	.rm_addr_received	=
> > > > __bpf_mptcp_pm_rm_addr_received,
> > > 
> > > Out of curiosity: I see here that even the optional hooks are
> > > assigned:
> > 
> > Optional hooks must be assigned here, otherwise this hook cannot be
> > defined in BPF.
> 
> OK, thanks!
> 
> > > does it mean that all function pointers will never be NULL and
> > > checks
> > > like 'pm->ops->add_addr_received' will always be true with a BPF
> > > PM?
> > > Or
> > > is it still OK to assign them to NULL for a new BPF PM?
> > 
> > I think it's the latter, it's OK to assign them to NULL.
> 
> If you have the infrastructure ready, can you check if you can set
> add_addr_received to NULL in a new BPF struct_ops mptcp_pm_ops for
> example please? Also, just to be sure, can you also check that in
> this
> case, in the pm.c, pm->ops->add_addr_received is also set to NULL and
> not to __bpf_mptcp_pm_add_addr_received? (not urgent)

Sure, here's the test:

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f9fed096d77c..6bdca0dcf21e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -578,6 +578,9 @@ void mptcp_pm_add_addr_received(const struct sock
*ssk,
        pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
                 READ_ONCE(pm->accept_addr));
 
+       pr_info("%s name=%s, pm->ops->add_addr_received=%p\n",
+               __func__, pm->ops->name, pm->ops->add_addr_received);
+
        mptcp_event_addr_announced(ssk, addr);
 
        spin_lock_bh(&pm->lock);

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
b/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
index 2f8e0e85b5d7..8aa4b8c9ce33 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
@@ -265,4 +265,5 @@ struct mptcp_pm_ops bpf_userspace = {
        .init                   = (void *)mptcp_pm_userspace_init,
        .release                = (void *)mptcp_pm_userspace_release,
        .name                   = "bpf_userspace",
+       .add_addr_received      = (void *)NULL,
 };

And the output:

[   18.229067][    C0] MPTCP: mptcp_pm_add_addr_received name=kernel,
pm->ops->add_addr_received=00000000cd865d66
[   18.231316][    C0] MPTCP: mptcp_pm_add_addr_received name=kernel,
pm->ops->add_addr_received=00000000cd865d66
[   21.105658][    C0] MPTCP: mptcp_pm_add_addr_received
name=bpf_netlink, pm->ops->add_addr_received=00000000fe7b7426
[   21.106419][    C0] MPTCP: mptcp_pm_add_addr_received
name=bpf_netlink, pm->ops->add_addr_received=00000000fe7b7426
[   24.767318][    C0] MPTCP: mptcp_pm_add_addr_received
name=userspace, pm->ops->add_addr_received=0000000000000000
[   28.220824][    C0] MPTCP: mptcp_pm_add_addr_received
name=bpf_userspace, pm->ops->add_addr_received=0000000000000000
[   36.623859][    C0] MPTCP: mptcp_pm_add_addr_received
name=bpf_hashmap, pm->ops->add_addr_received=0000000000000000
# #187/1   mptcp/connect:OK
# #187/2   mptcp/base:OK
# #187/3   mptcp/mptcpify:OK
# #187/4   mptcp/subflow:OK
# #187/5   mptcp/iters_subflow:OK
# #187/6   mptcp/netlink_pm:OK
# #187/7   mptcp/bpf_netlink_pm:OK
# #187/8   mptcp/userspace_pm:OK
# #187/9   mptcp/bpf_userspace_pm:OK
# #187/10  mptcp/iters_netlink_address:OK
# #187/11  mptcp/iters_userspace_address:OK
# #187/12  mptcp/bpf_hashmap_pm:OK
# #187/13  mptcp/sockopt:OK
# #187/14  mptcp/default:OK
# #187/15  mptcp/first:OK
# #187/16  mptcp/bkup:OK
# #187/17  mptcp/rr:OK
# #187/18  mptcp/red:OK
# #187/19  mptcp/burst:OK
# #187/20  mptcp/stale:OK
# #187     mptcp:OK

pm->ops->add_addr_received is set to NULL indeed, whether we use
".add_addr_received = (void *)NULL," so that it is explicitly set to
NULL, or simply do not assign a new function to it but assign other
function pointers.

Thanks,
-Geliang

> 
> Cheers,
> Matt

