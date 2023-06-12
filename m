Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52610797
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686578078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isDu2pduu+5CDySn371GBtRGUZnLyhAIThKpLV4ZXmA=;
	b=QPCDwkiTy3/ekY3hCxUMwx9KspYgEpaAzksUBZP2gvH96IyY3fHzoxF2yu/x0y7x9CQCSq
	9S62RTIQlughotutliVJ0Sij13SJ+GTNZZbKIzWMRG7AlswrorL3/VXUiZZqQE3a155ACG
	MRK+nGxvL++0tRQG7ljWJOEieUSZJX0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-3T5fj9DNPxK3eT9jz0c74A-1; Mon, 12 Jun 2023 09:54:37 -0400
X-MC-Unique: 3T5fj9DNPxK3eT9jz0c74A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-977e6c94186so393542966b.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 06:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578075; x=1689170075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isDu2pduu+5CDySn371GBtRGUZnLyhAIThKpLV4ZXmA=;
        b=cbn2rKBxrg/JTjdxsAWP9fPa4Jj7nl5Ql6L3nf7u9i/Zqocu9ZS6u11XcFi6GkMCe+
         fMClbTEJMcQ2kbDlLAW8wFmi7tN51yvzSPVx0QVfxFZFP305kGaQRtfLPfbRCE7qYDtJ
         ldFgXFkBJ+sECjqpQ0Kkfqqf4tMlJQuW9IgBMDcBuPw4CM53oXbVRhyutJ2/HNAeuzAO
         Href+ZFrDMOo5lpKt7xVfqdqb0GDx6HQIU3xl2cGSWVyzYXnUcv0f30f0UrlIk+2XkEG
         v4pUXq6QEag+aemI8sfLOZajsaS737098hUp0D9QmDfPmrYoPypUX2meGoPGHsTcRtyV
         FdVA==
X-Gm-Message-State: AC+VfDwtKuXAeM3aZLa4N/oF043xMOS3lpKEMp1qpPGh/E0bh8kZ6lF7
	fsGdDLWTWUw7lkcTtlgq4X/63SXHr1ioFkar5pb9giQt7gzRdb1AKePuRKieQwxyiaKj1ZeN8RA
	2batcXHqHHZehDOrY1pCAD5c=
X-Received: by 2002:a17:906:db0a:b0:977:befe:d888 with SMTP id xj10-20020a170906db0a00b00977befed888mr9358936ejb.13.1686578074832;
        Mon, 12 Jun 2023 06:54:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5m81mOnL1F7qspLgfXs8DjadrBpGpGUmMcGIaqxU9Bt/s0V1Xa731u/0hpnvuXxO9GpiRj5w==
X-Received: by 2002:a17:906:db0a:b0:977:befe:d888 with SMTP id xj10-20020a170906db0a00b00977befed888mr9358915ejb.13.1686578074475;
        Mon, 12 Jun 2023 06:54:34 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709062bcb00b00977eec7b7e8sm5249523ejg.68.2023.06.12.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:54:33 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:54:33 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: convert netlink from small_ops to
 ops
Message-ID: <ZIcjmflYHQMZ0p2H@dcaratti.users.ipa.redhat.com>
References: <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
 <a5feec31cd5025a0357b8f60293b0879d3bb1461.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a5feec31cd5025a0357b8f60293b0879d3bb1461.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Paolo, thanks for looking at this!

On Mon, Jun 12, 2023 at 12:15:59PM +0200, Paolo Abeni wrote:
> Hi Davide,
> 
> Overall LGTM, there are just a few small hints see below.
> 
> On Mon, 2023-06-12 at 11:39 +0200, Davide Caratti wrote:
> > this prepares MPTCP control plane to be described as YAML spec.
> 
> I think the commit message should be expanded, alike
> 
> """
> After the change the mptcp protocol will use per op policy. Update
> the commands implementation to pass the relevant policy all the way
> down to the actual impl.
> """
> 
> Or whatever makes really sense ;)

Ok!

[...]
> > 
> > +
> > +/* MPTCP_PM_CMD_FLUSH_ADDRS - do */
> > +static const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
> > +	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
> > +	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
> > +	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
> > +	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
> > +	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
> > +	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
> > +	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
> > +};
> 
> Out of sheer ignorance, to we need to declare 4 different structs with
> the same contents? Can't we reuse a single one 4 times?

good point. Well, "per-op" implies (theoretically) that validation of the
same attribute set can be different per-op: for example, you might want to
remove an endpoint with 'id' equal to 0, but you can't add one having id = 0.
The code I added is taken from the output of ynl-cli, and you might have
noticed that I added the #define trick for "endpoint" because  the tool
didn't generate any policy for the nested attribute...

Honestly I thought it would have been sufficient to specify "aliases" in
request/replies, like "&add_addr_attrs" and "*add_addr_attrs" :

<...>

   -
      name: add_addr
      doc: Add endpoint
      attribute-set: endpoint
      dont-validate: [ strict ]
      flags: [ uns-admin-perm ]
      do:
        request: &add_addr_attrs
          attributes:
            - family
            - addr4
            - addr6
            - id
            - port
            - if_idx
            - flags
    -
      name: del_addr
      doc: Delete endpoint
      attribute-set: endpoint
      dont-validate: [ strict ]
      flags: [ uns-admin-perm ]
      do:
        request: *add_addr_attrs
<...>

but this generated 2 separate struct of the same type, namely
mptcp_pm_add_addr_nl_policy and mptcp_pm_del_addr_nl_policy.

[...]

> > @@ -1183,7 +1258,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
> >  
> >  	/* no validation needed - was already done via nested policy */
> >  	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> > -					  mptcp_pm_addr_policy, info->extack);
> > +					  nla_policy,
> > +					  info->extack);
> 
> Minor nit: I think we can use a single line for both 'nla_policy' and
> 'info->extack);'

yes, sure, will fix this in v4

[...]
> 
> > @@ -1236,19 +1312,22 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
> >  
> >  	memset(addr, 0, sizeof(*addr));
> >  
> > -	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
> > +	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, mptcp_pm_endpoint_nl_policy, addr, true);
> >  }
> >  
> >  int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> > -			 bool require_family,
> > +			 int cmd, bool require_family,
> >  			 struct mptcp_pm_addr_entry *entry)
> >  {
> >  	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> > +	const struct nla_policy *nla_policy = mptcp_nl_cmd2policy(cmd);
> >  	int err;
> 
> Nit: reverse x-mas tree above

sure, will fix it in v4
> 
> >  
> >  	memset(entry, 0, sizeof(*entry));
> >  
> > -	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
> > +	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info,
> > +					  nla_policy,
> > +					  &entry->addr, require_family);
> 
> Nit: 
> 					  tb, attr, info, nla_policy,

sure, will fix it in v4

 
> > @@ -1305,7 +1384,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> >  	struct mptcp_pm_addr_entry addr, *entry;
> >  	int ret;
> >  
> > -	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
> > +	ret = mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_ADD_ADDR, true, &addr);
> 
> Can we pass to mptcp_pm_parse_entry() directly the relevant policy
> instead of the cmd? it will avoid the need for mptcp_nl_cmd2policy()
> and possibly for the 'duplicated' definitions above.

this will avoid the need for mptcp_nl_cmd2policy(), but it won't probably
eliminate the dups in the long term, when yamlification will be in place.
(I need to confirm this by looking again at the tool, will let you know).

-- 
davide

