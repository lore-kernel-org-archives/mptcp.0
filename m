Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477865F85B
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765739; cv=none; b=mp/aiyFhvWlNg2apFJfNGXB2AYeJOwyUdgWL888ehQZCOHUs0oVpItls+gU1bmZF9Ymv6Xg5B+lSwMW+ancahnRRsbact4GRFrEI1JrDustWY/lZ1I40Gqt4QddaGkXRM1RR7eFPplwG+PKiO1VYLAx95bQ11PJsNNlPhzxLzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765739; c=relaxed/simple;
	bh=YPp0X8xytf1YWDTJkvZZnJovdUP15fUBAl2fer7bPKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTzPx0gICD0iUY3w+zqHh+V4lxeELsOqCidl9gx7N9Kjroowi0RFDJsCe9wi+TpoV36nLrtU29qN/Gx0MYrkM9vZb9ADplBOuQyRvG71VzVlZki53cbP0uZhDrq/N/oSBRsDgEGEJAJz8E6MyuMQLZleIiXkTQ+m7Yh89j6keAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYFeZzuw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYFeZzuw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2a17f3217aso59291166b.2
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 21:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706765735; x=1707370535; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5D6EXwnEPsxN9ZAV5iPDUPMNs2BlXcQs70krW243ook=;
        b=FYFeZzuwY1MJFRnvG7X67MO45PJ7vRe+xZNrDHr4a+oHOLzINihGhlM9w+9Y7opCJl
         DvYvzrxHH6BwQ/esAXQF8kCc/BX8pdDqi6jOVSeWTyIi5vQNWPdZXFtk3j0EphDILHf+
         0SfqlL7IKMTmXeOdjaq66TOh+Ck2jTnCZTO2/2NKJy3mBSQ2MyeoVxd1ZTM77uJLJGWX
         O+n5cMAaFc2wj+le1LkE7SBko7LuFjZba7R50wc5sG6TadcVaFVuPOn8p3AsL1E08MjZ
         Nzt0EPJe8dVOcqg2CV5G6Q/uYKmDRbporMkm4ODkalyDkFU1Orgz31aFnjo4dv+s1i6q
         tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706765735; x=1707370535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D6EXwnEPsxN9ZAV5iPDUPMNs2BlXcQs70krW243ook=;
        b=mpY0pd6QEj/nBsB3nkPKZx2XEaBHKtBzMmw0fdmVsGeQ1gR7D1wai3gY0X4uC/4fa2
         cmAoY0av9FgjuoaUFMaMUx5NbGl2ZGB8Eev8M1WLn9xzR2AW3eJ8KGWMRhRgZ8vLdTF8
         GRIoimdfZZ5x/RAYjzJHge2aAlVrsEBlDjyzlgCRx4kmNYzte8wLVnr0HKACLT7u5EPM
         t07u5JrdVEfsJCUFt7IY15CPngKeQQgWsdbs72n1odUeJsTOcQw8uJA8/hvbfI5qcwmH
         FYFugEU+U0QPOJiczfsEQCHefJtpkfrII0nj6qC/zXI/y/Qev0+KQwTY5SRgcTyI4MkB
         Ju8g==
X-Gm-Message-State: AOJu0YyGI37Ufo+o/pd/mdG3HlbZNzPZCHMCqmamwYzWLRlU+D4PEAcV
	o9VpvRXDvJp7poiHI/ikXt6zsHrD2JkiMSAQ2MFhYr9PgXexsso/GLLfD+v5FnRyJYE+hcLDc7b
	9JgQuGAI0H3hSvJsojZeuoiTZM8XAFiIgHJU=
X-Google-Smtp-Source: AGHT+IFtj6WQxhekz7I7v/gX8g/wDcFK6MerOUOp387TAG35LqmRUUv3s886poLLQSRHEiD+wx+wVM97vaxaOfMo6yQ=
X-Received: by 2002:a17:906:35d8:b0:a28:ec67:185f with SMTP id
 p24-20020a17090635d800b00a28ec67185fmr2620156ejb.60.1706765734968; Wed, 31
 Jan 2024 21:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706759413.git.tanggeliang@kylinos.cn> <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
In-Reply-To: <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 1 Feb 2024 13:35:23 +0800
Message-ID: <CA+WQbwue9GJFK+=KQk6nbr_mv9oyDjC+g0ed7awLzWKVxobXRQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 2/4] mptcp: add needs_id for netlink appending addr
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Just the same as userspace PM, a new parameter needs_id is added for
> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
>
> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
> ID is set from PM or not. It will be used in the next two commits.
>
> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
> needs_it.
>
> Fixes: fd5a4c04e18 ("mptcp: add the address ID assignment bitmap")

 Sorry, should be efd5a4c04e18 here.

-Geliang

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d9ad45959219..9367ab506908 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -901,7 +901,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
>  }
>
>  static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> -                                            struct mptcp_pm_addr_entry *entry)
> +                                            struct mptcp_pm_addr_entry *entry,
> +                                            bool needs_id)
>  {
>         struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
>         unsigned int addr_max;
> @@ -949,7 +950,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>                 }
>         }
>
> -       if (!entry->addr.id) {
> +       if (!entry->addr.id && needs_id) {
>  find_next:
>                 entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
>                                                     MPTCP_PM_MAX_ADDR_ID + 1,
> @@ -960,7 +961,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>                 }
>         }
>
> -       if (!entry->addr.id)
> +       if (!entry->addr.id && needs_id)
>                 goto out;
>
>         __set_bit(entry->addr.id, pernet->id_bitmap);
> @@ -1092,7 +1093,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
>         entry->ifindex = 0;
>         entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>         entry->lsk = NULL;
> -       ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +       ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
>         if (ret < 0)
>                 kfree(entry);
>
> @@ -1285,6 +1286,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
>         return 0;
>  }
>
> +static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
> +                                     struct genl_info *info)
> +{
> +       struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +
> +       if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> +                                        mptcp_pm_address_nl_policy, info->extack) &&
> +           tb[MPTCP_PM_ADDR_ATTR_ID])
> +               return true;
> +       return false;
> +}
> +
>  int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>         struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
> @@ -1326,7 +1339,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
>                         goto out_free;
>                 }
>         }
> -       ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +       ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> +                                               !mptcp_pm_has_addr_attr_id(attr, info));
>         if (ret < 0) {
>                 GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
>                 goto out_free;
> --
> 2.40.1
>
>
