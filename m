Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B32C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637317416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Db0M29cbebQ59M4ziNtCeVA1MuuEISRzPC7B6lJaT/E=;
	b=MyqKObs3EM701V/SW4tGV9/4xlrOCMMa61/OI/kQCvIDYyhc7uMnp8IEKFSR74hH3dDg69
	KZxY3XaYa/p0jXg3Nfub3ezyc2ej4kwd53HfCXdpIMfP+5Ev3ztiRZNQGj1Epoh/YuX3jI
	W7+KsNSM1gk2Gt8MkNYzf9LVgACAMQI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-Z6bSHJ1iNCO-NjagpkflGw-1; Fri, 19 Nov 2021 05:23:34 -0500
X-MC-Unique: Z6bSHJ1iNCO-NjagpkflGw-1
Received: by mail-ed1-f70.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso8007275eds.12
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 02:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Db0M29cbebQ59M4ziNtCeVA1MuuEISRzPC7B6lJaT/E=;
        b=Vcd6v79uLszh0/UYgYd8EUkFBXyAUUJaGly752Y5jV3MbtHP4znjI7H6DDyO0VW45p
         htQVn1vKiFTdluAgmMpC0vYlbNjXOyNfVc3Cv1dAeXj6WRlGbBSr2nm92Q9lVhWaq/jO
         cfIlZGGcisxz6Hk4fK5fbXMlJotY7eZ4FvwuaLLl+2WYLm7amE0XzQOXj2M0ZzG3iQ4p
         MuZ6hfVegNto6aaJ6F9wBBswJ2LZ+6im0n5rxLR3W9EY3QJDh819JslJl4eqa6TUTozU
         YxhA1Aiu+MQLY025G/A/lyQwJQMNRlJ4NzCJQYCsy+c/ace+GgBIIbGL/V8l6j8Lf8Qv
         3LQw==
X-Gm-Message-State: AOAM533kwb1IRHRs0sTw1vlsm2Vk3SHn2d1O0VenOgED+4/O3ETIzWyb
	oDR/mg6j4MNfsIcLus+08iRftpG/tsGzly7eFPursBPGO/6RUhq/UJkpvfszwpuKBlaPs+9xib2
	OthccxYKCIe5G22o=
X-Received: by 2002:a05:6402:1cb2:: with SMTP id cz18mr22154285edb.99.1637317413299;
        Fri, 19 Nov 2021 02:23:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyayMG35/td2emZKV89VwaIevT2muxbAoAf8/HpsXi6AFCE67FLfRx1l2X3jq8gvavcsAbdPg==
X-Received: by 2002:a05:6402:1cb2:: with SMTP id cz18mr22154234edb.99.1637317412961;
        Fri, 19 Nov 2021 02:23:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id cw5sm1038241ejc.74.2021.11.19.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:23:32 -0800 (PST)
Message-ID: <f19d5c924b9845cde76d09e124ee0e35a5f4b6ed.camel@redhat.com>
Subject: Re: [PATCH iproute2-next] mptcp: add support for fullmesh flag
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 19 Nov 2021 11:23:31 +0100
In-Reply-To: <cb4e18f4-a3fe-fb46-2ab-eb37e29f573d@linux.intel.com>
References: <e82f1c57baf4bab35018177cf82de224655fcb8b.1637238533.git.pabeni@redhat.com>
	 <cb4e18f4-a3fe-fb46-2ab-eb37e29f573d@linux.intel.com>
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

On Thu, 2021-11-18 at 17:31 -0800, Mat Martineau wrote:
> On Thu, 18 Nov 2021, Paolo Abeni wrote:
> 
> > The link kernel supports this endpoint flag since v5.15, let's
> > expose it to user-space. It allows creation on fullmesh topolgy
> > via MPTCP subflow.
> > 
> > Additionally update the related man-page, clarifying the behavior
> > of related options.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > notes:
> > - currently sent only to mptcp ML, looking for "editorial" reviews :)
> > - as a side doc-update effect, this could possibly close issue/237
> > 
> > ---
> > ip/ipmptcp.c        |  3 ++-
> > man/man8/ip-mptcp.8 | 47 ++++++++++++++++++++++++++++++++++-----------
> > 2 files changed, 38 insertions(+), 12 deletions(-)
> > 
> > diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> > index 0f5b6e2d..433fa68d 100644
> > --- a/ip/ipmptcp.c
> > +++ b/ip/ipmptcp.c
> > @@ -31,7 +31,7 @@ static void usage(void)
> > 		"	ip mptcp limits show\n"
> > 		"	ip mptcp monitor\n"
> > 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
> > -		"FLAG  := [ signal | subflow | backup ]\n");
> > +		"FLAG  := [ signal | subflow | backup | fullmesh ]\n");
> > 
> > 	exit(-1);
> > }
> > @@ -53,6 +53,7 @@ static const struct {
> > 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
> > 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> > 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> > +	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
> > };
> > 
> > static void print_mptcp_addr_flags(unsigned int flags)
> > diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> > index 22335b61..367ecc64 100644
> > --- a/man/man8/ip-mptcp.8
> > +++ b/man/man8/ip-mptcp.8
> > @@ -53,6 +53,8 @@ ip-mptcp \- MPTCP path manager configuration
> > .B subflow
> > .RB "|"
> > .B backup
> > +.RB "|"
> > +.B fullmesh
> > .RB  "]"
> > 
> > .ti -8
> > @@ -103,22 +105,36 @@ is a unique numeric identifier for the given endpoint
> > 
> > .TP
> > .BR signal
> > -the endpoint will be announced/signalled to each peer via an ADD_ADDR MPTCP
> > -sub-option
> > +the endpoint will be announced/signaled to each peer via an ADD_ADDR MPTCP
> 
>     ^^^
> Suggest capitalizing the first "The" since the preceeding "signal" is not 
> part of the sentence.
> 
> > +sub-option. Upon reception of an ADD_ADDR option, the peer can try to create
> > +additional subflows, see
> > +.BR ADD_ADDR_ACCEPTED_NR.
> > 
> > .TP
> > .BR subflow
> > -if additional subflow creation is allowed by MPTCP limits, the endpoint will
> > -be used as the source address to create an additional subflow after that
> > -the MPTCP connection is established.
> > +if additional subflow creation is allowed by MPTCP limits, after that the
> 
>     ^^
> Capitalize here too.
> 
> > +MPTCP connection is established, the MPTCP path manager will try to create
> > +an additional subflow using this endpoint as the source address.
> 
> I would rearrange this one:
> 
> If additional subflow creation is allowed by the MPTCP limits, the MPTCP
> path manager will try to create an additional subflow using this endpoint
> as the source address after the MPTCP connection is established.
> 
> > 
> > .TP
> > .BR backup
> > -the endpoint will be announced as a backup address, if this is a
> > -.BR signal
> > -endpoint, or the subflow will be created as a backup one if this is a
> > +if this is a
> 
>     ^^
> 
> Capitalize.
> 
> > +.BR subflow
> > +endpoint, the subflows created using this endpoint will be backup ones.
> > +Backup subflows are used only when all non-backup subflows are unavailable.
> > +
> 
> Suggestion:
> 
> If this is a
> .BR subflow
> 
> endpoint, the subflows created using this endpoint will have the backup 
> flag set during the connection process. This flag instructs the peer to 
> only send data on a given subflow when all non-backup subflows are 
> unavailable. This does not affect outgoing data, where subflow priority 
> is determined by the backup/non-backup flag received from the peer.

Agreed
> 
> 
> > +.TP
> > +.BR fullmesh
> > +if this is a
> 
>     ^^
> "If"
> 
> > +.BR subflow
> > +endpoint, if additional subflow creation is allowed by MPTCP limits, after that the
> > +each MPTCP connection is established, the MPTCP path manager will try to create
> > +an additional subflow for each known server address using this endpoint as
> > +the source address. If the peer did not announce any additional address via
> > +ADD_ADDR MPTCP sub-option, this has no additional effect compared to a plain
> > .BR subflow
> > -endpoint
> > +endpoint. Otherwise, this will create an additional subflow for each received
> > +ADD_ADDR, generating a fullmesh topology.
> 
> Suggestion:
> 
> If this is a
> .BR subflow
> endpoint and additional subflow creation is allowed by the MPTCP limits, 
> the MPTCP path manager will try to create an additional subflow for each 
> known peer address, using this endpoint as the source address. This will 
> occur after the MPTCP connection is established. If the peer did not 
> announce any additional addresses using the ADD_ADDR MPTCP sub-option, 
> this will behave the same as a plain
> .BR subflow
> endpoint. When the peer does announce addresses, each received ADD_ADDR 
> will trigger creation of an additional subflow to generate a full mesh 
> topology.

Agreed

> 
> 
> > 
> > .sp
> > .PP
> > @@ -143,8 +159,17 @@ endpoints, additional subflows started by the peer.
> > .TP
> > .IR ADD_ADDR_ACCEPTED_NR
> > specifies the maximum number of ADD_ADDR suboptions accepted for each MPTCP
> > -connection. The MPTCP path manager will try to create a new subflow for
> > -each accepted ADD_ADDR option, respecting the
> > +connection.
> 
> splitting here for edits
> 
> > When and ADD_ADDR suboption is accepted, if there are no local
> > +.BR fullmesh
> > +endpoint, the MPTCP path manager will try to create a new subflow towards the
> > +address specified by the ADD_ADDR option, using as source the local address
> > +obtained by the routing resolution.
> 
> "When an ADD_ADDR sub-option is received and there are no local fullmesh 
> endpoints, the MPTCP path manager will try to create a new subflow using 
> the address in the ADD_ADDR as the destination address and a source 
> address determined using local routing resolution. When fullmesh endpoints 
> are available, the MPTCP path manager will try to create new subflows 
> using each fullmesh endpoint as a source address and the peer's ADD_ADDR 
> address as the destination. In both cases the SUBFLOW_NR limit is 
> enforced."
> 
> (I hope I kept the intended meaning here?)

I think it's would be better retaining "sub-option is accepted" instead
of "received", so we related to the above paragraph.
> 
> 
> I think there is a mix of "ADD_ADDR option", "ADD_ADDR suboption", and 
> "ADD_ADDR sub-option" above, even after my edits. Should probably choose 
> one and be consistent with it!

I will try to stick to "ADD_ADDR sub-option"

Thanks!

Paolo

