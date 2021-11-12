Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2468
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636731634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6yTan/NIasIPZrqJwzd0PkpU/TwztFR25BapQWGd9A=;
	b=YgprxMlr8RvVcC9T3MwvIas4iPtlz+38H/QX+CjgZi4CVyczvetFpvcJSPvrendKbXv/hr
	2gdoT0WC0+EpUzI22f1DhqfxR64FzhsyCLmoGwOHSK8Be0ngxYNGa0CLcRuHeWCdFTpuXE
	ELsc7SQxnD9ZKa2X5KtAamBlsMJdGvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Lcu9HHH0ND-FCZ4pI8pFUQ-1; Fri, 12 Nov 2021 10:40:31 -0500
X-MC-Unique: Lcu9HHH0ND-FCZ4pI8pFUQ-1
Received: by mail-wr1-f70.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so1657621wrc.22
        for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 07:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l6yTan/NIasIPZrqJwzd0PkpU/TwztFR25BapQWGd9A=;
        b=NB0EEZTBDXBEl+wFmY9/iF8YZBta2LSqnSIb7XHvW+xzc6mEQtwTTT20w68uJuSTdG
         wprGDzTKEky8DAvV0nP76w6EavZEZRWq1d3rhKeVVca4U2CWR9oaHhgl1YsTxP9RlvvZ
         p9raZvDvA2jYMIa3d91lyFY+RfUeB5DSYhIDhuTlywd+kdRXOVP+soW8h8xBNECCZghi
         ni1yiQnm3R7OuzL9w+pb0CT7hPCxBVenGMtfPwffKT3ShAa9CUtgED4kJT74cqtzZlEi
         VgmsWEjsE8Buo0IryH3gFhIcBrMA/ErzmynJ1cN4rhnOpag+Ll2iMVXIQtX/veHsitup
         ZErA==
X-Gm-Message-State: AOAM5323QjnrgxzZ6frUdRZt59wZ1k783ICru7uePxAjEk6aT5bucDuR
	9ETbvc8+l14MPo9hiRoV3+x5nJuIhYAxkBCVIp94qWaPBezdFrn2anXswML3E5ig4yNftEYChku
	0dY/c5gX7poo6LAM=
X-Received: by 2002:a7b:c197:: with SMTP id y23mr18745128wmi.44.1636731629983;
        Fri, 12 Nov 2021 07:40:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4B3kdcl0Qx0r1Rh4WEIKO3txKMMMAuEs5ho70ybzsetrb5ASiYeizbhEzIBV+uU0PR4n0QA==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr18745102wmi.44.1636731629756;
        Fri, 12 Nov 2021 07:40:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id q84sm13851388wme.3.2021.11.12.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:40:29 -0800 (PST)
Message-ID: <3ffc052c1d4f086397620b0a1f220c76245e0fd8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: allow changing the "backup" bit by
 endpoint id
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 12 Nov 2021 16:40:27 +0100
In-Reply-To: <YY6C5wrG94WYonzg@dcaratti.users.ipa.redhat.com>
References: <434d58757c972252e5af7ac2574c3791a9778441.1636628783.git.dcaratti@redhat.com>
	 <f468c1e1-ec26-763a-bc3-0b080b7a9db@linux.intel.com>
	 <YY6C5wrG94WYonzg@dcaratti.users.ipa.redhat.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Fri, 2021-11-12 at 16:06 +0100, Davide Caratti wrote:
> hello Mat, thanks for reading,
> 
> On Thu, Nov 11, 2021 at 04:09:13PM -0800, Mat Martineau wrote:
> > On Thu, 11 Nov 2021, Davide Caratti wrote:
> > 
> > > a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
> > > the value of 'backup' bit by simply specifying the endpoint id.
> > > 
> > > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
> > > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> > > ---
> > > net/mptcp/pm_netlink.c | 19 +++++++++++++++----
> > > 1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 7b96be1e9f14..b4c647e67930 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -1700,24 +1700,35 @@ static int mptcp_nl_addr_backup(struct net *net,
> > > 	return ret;
> > > }
> > > 
> > > +static int mptcp_nl_set_flags_idzero(u8 flags)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > 
> > Hi Davide -
> > 
> > Is the above function added as a placeholder for something in the future?
> 
> yes it's meant to be a placeholder, and I should have mentioned it in the
> commit message. Any advice on what should happen from the functional
> point of view when we change the "backup" bit for id=0 ?

IMHO explicitly forbidding the switch of the backup flag on id 0 is the
correct thing to do. I guess/expect the backup flag will change in
response to some "meta-change" on the related link.

e.g. the end-user has free 5g connectivity when attached to the home's
cell, and turn off backup flag on the address[es] attaches to the 5G
link.

I don't easily see an use-case for id 0

BTW:

> +	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry; 

Is checkpatch happy about the above? I would move '*entry' on a
different line for readability's sake

> > Seems like a direct return below would be clearer.
> 
> with a TODO comment, also. But just aesthetic, because probably the
> compiler should make no difference and inline the call to
> mptcp_nl_set_flags_idzero().

Yep, generated-code wise would be the same. If we choose to forbid the
id 0, I think it will made the code more readable.

Cheers,

Paolo

