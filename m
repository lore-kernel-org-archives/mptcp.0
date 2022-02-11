Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B147F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 23:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644621093; x=1676157093;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wGV5YsolV08D4500oMKuU3c7QMUwmbw+WWsaPsNS0DE=;
  b=GMJG1ylCc/pVF9JlDMXnsttFKVmgO4KS6k8H0pCaJhCzBoi4hOVpmVw0
   tRXSiOaleH7vJNKWwnQy+LmAyEx2sdLP987MVljucYKrFkziL6gRwkwbZ
   LvVpof+TvV8u+C/bnqvGKdQGsIk2b3n1BsR0LqIKzbDw0kYfy4s0a92tn
   VFRnGBlC1lY1wdckJW3Hh8Jq4c86m3UheHujeECFeYfUP7RoKQQwoAsqH
   n/yeUhvFtblFenEKAgTkuA6NbWYE2oWAK6R4CIxUWo9vM28glzRD1Q6SO
   HL1y3sGcwaXE8oRhbCCfKr5unc+wJL+p4CpZnppdwoiqjE+1gQN0wvww2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249574460"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249574460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 15:11:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542277534"
Received: from kpdespai-mobl.amr.corp.intel.com ([10.212.245.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 15:11:24 -0800
Date: Fri, 11 Feb 2022 15:11:24 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 1/3] Squash-to: "mptcp: constify a bunch
 of of helpers"
In-Reply-To: <f63ac7eafde9820e4a85e4f9d09630509e42119c.1644518737.git.pabeni@redhat.com>
Message-ID: <a6b82646-4beb-c5d6-b6f-f18382926470@linux.intel.com>
References: <cover.1644518737.git.pabeni@redhat.com> <f63ac7eafde9820e4a85e4f9d09630509e42119c.1644518737.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Feb 2022, Paolo Abeni wrote:

> There are a few more helpers that can be const-ified and I missed
> in the previous patch, just squash these change into there.
>

Ok, looks good to squash. Thanks.

-Mat

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 46346f009485..56f5603c10f2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1289,7 +1289,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
> }
>
> static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> -				      struct mptcp_addr_info *addr)
> +				      const struct mptcp_addr_info *addr)
> {
> 	struct mptcp_pm_add_entry *entry;
>
> @@ -1304,7 +1304,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> }
>
> static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
> -				      struct mptcp_addr_info *addr,
> +				      const struct mptcp_addr_info *addr,
> 				      bool force)
> {
> 	struct mptcp_rm_list list = { .nr = 0 };
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
