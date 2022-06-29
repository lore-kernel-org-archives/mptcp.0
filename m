Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EF7A
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656500116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dtx8aZCya6nZmXPWgnwd1MFQiutqIlatDb4dW/13vAY=;
	b=OIF9noIYDvWgKMG43Y9nvSaLH50DMhdLMagNcAUmd1fvWMz2lyKtyKbOQzkqnUScmUfc0X
	SoflHQJsSGoEI4PZiBENeuhj3eBiO8fLl9gv/2g7DBxpUsREzAfqTNTYdC9vZZHIf8tLiy
	HTcNOvD4pW0yv+hq+I9qUQN3WQKDMD8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-qZKl_VA-Px2erwpGADqIHg-1; Wed, 29 Jun 2022 06:55:15 -0400
X-MC-Unique: qZKl_VA-Px2erwpGADqIHg-1
Received: by mail-wr1-f69.google.com with SMTP id az28-20020adfe19c000000b0021bc8df3721so1619898wrb.7
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 03:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Dtx8aZCya6nZmXPWgnwd1MFQiutqIlatDb4dW/13vAY=;
        b=e/TwRNvAO2EehLf1k38doMMe2LMrAWjjWOJSfeXY1LbaqEnNsbTeVyd/yR3vxnXh7b
         +34MzbTTbdI3sdt4PPIHXClam6tdOY8fBLDMpLgzjFAIg4NKNwylCFiei750O1AvbZ6z
         iSD8h3FpsqQp3H+peLMjTS1mM124T2xwQA8N0MJ5gnwaKWh16HTy8tZgbh5r4QF98pcS
         i8d39rHKksvDbrD/CrovUE7+/W+T9u9eD5CIxys3+3DB8HAz5i40zDodoglxqPpM+vZT
         0lmsSY3sUA4qlKwuVsiiAeZS4OfY+zOYyuSGljuy4a1w20ZUx8+0VutSrnrtKDjHiUKQ
         W2jA==
X-Gm-Message-State: AJIora+sOTuCjmLkIQFaugb/Cvu1fsnbCwJ899YXIaOpvtYCfX2eRhCN
	E86u9cEwC2Up9u02ElUpozNQ3J4b8gYGQQ2QEvtJGHBEHwJc58IUwnvJdjRftpEz83IRimxXjt8
	KpFYfaxfECwBa4P8=
X-Received: by 2002:adf:f146:0:b0:21b:8c7d:7294 with SMTP id y6-20020adff146000000b0021b8c7d7294mr2411004wro.582.1656500114162;
        Wed, 29 Jun 2022 03:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNtsJhQmllVmAygjYaSYfUCjaQM8q6mdD815WBLIUrI/Q0o2t8VRqfECQkIaZh+zLZAh1N7g==
X-Received: by 2002:adf:f146:0:b0:21b:8c7d:7294 with SMTP id y6-20020adff146000000b0021b8c7d7294mr2410990wro.582.1656500113888;
        Wed, 29 Jun 2022 03:55:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c149200b003a04c74efd1sm2721652wmh.21.2022.06.29.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:55:13 -0700 (PDT)
Message-ID: <08338fd031ddcb369d37f765cfbddf933cc3fdad.camel@redhat.com>
Subject: Re: [PATCH RFC 3/4] mptcp: allow the in kernel PM to set MPC
 subflow priority
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 29 Jun 2022 12:55:11 +0200
In-Reply-To: <31cf8780-ea9f-fdf7-dffa-b77c831747@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com>
	 <8a80c3bf12e43985e00b4fb04beccd38d69e505b.1656088406.git.pabeni@redhat.com>
	 <31cf8780-ea9f-fdf7-dffa-b77c831747@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-06-28 at 17:11 -0700, Mat Martineau wrote:
> On Fri, 24 Jun 2022, Paolo Abeni wrote:
> 
> > Any local endpoints configured on the address matching the
> > MPC subflow are currently ignored.
> > 
> > Specifically, setting a backup flag on them has no effect
> > on the first subflow, as the MPC handshake can't carry such
> > info.
> > 
> > This change refactors the MPC endpoint id accounting to
> > additionally fetch the priority info from the relevant endpoint
> > and eventually trigger the MP_PRIO handshake as needed.
> > 
> > As a result, the MPC subflow now switches to backup priority
> > after that the MPTCP socket is fully established, according
> > to the local endpoint configuration.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm_netlink.c | 37 +++++++++++++++----------------------
> > 1 file changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 91f6ed2a076a..a6eb501e5031 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -505,30 +505,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
> > 	struct mptcp_pm_addr_entry *entry;
> > 
> > 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> > -		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
> > +		if ((!lookup_by_id &&
> > +		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
> 
> It seems like we could have multiple entries in the local_addr_list with 
> the same address, but with different entries having port==0 or nonzero 
> ports. If mptcp_nl_cmd_set_flags() is called with a nonzero port, but this 
> lookup function encounters the port==0 entry first, this will match an 
> unexpected entry in local_addr_list.
> 
> Is there some other constraint preventing this?

Uhmmm.. I updated the mptcp_addresses_equal() statement to match the
existing one in lookup_id_by_addr() below.

You are right, this check is uncorrect, and generally speaking the
mptcp_addresses_equal() invocations are a bit fuzzy. I'll try to
clarify that with an additional patches:

- mptcp_addresses_equal() on subflow list use port matching if the
looked-up address has  non 0 port (the current code looks correct)

- mptcp_addresses_equal on local_addr_list should use port matching if
address_use_port(entry), and entry with port matching should be
preferred over entries without port-matching. The latter can be
enforces adding entries with address_use_port(entry) at the list head
and entries with !address_use_port(entry) at tail

WDYT?

Thanks!

Paolo

