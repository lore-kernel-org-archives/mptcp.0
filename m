Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23082568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645435010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsvZcOng5XXPuRARXQ+7a3z9T4rkRNuz0lYBj3ujo6o=;
	b=WLaEkJd6WVvw7YD0vKn6l0JzBuyUqP19cwKW9vX/2OooxbsB3/F05uFRyuGgpPo8j1nkf+
	uRH4wGEcj8B3KQHFBJmZXegQI6CTfxSfjGlJWHBNWSEl4aFiHS/qpho9M2FxcsazbxjdFH
	q1D7kAJ8TwewrJOYuspcyT6Ptf9huok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-UMynugU9NIK8ss6SLzRdQQ-1; Mon, 21 Feb 2022 04:16:49 -0500
X-MC-Unique: UMynugU9NIK8ss6SLzRdQQ-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so7791561wms.0
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 01:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YsvZcOng5XXPuRARXQ+7a3z9T4rkRNuz0lYBj3ujo6o=;
        b=DmaP079mUgMQw6jfyNu1WnzqsNwa92GCnTTvkLReWP77co144ZDhJSHMJx/8Dcqfxe
         R4zaCsw3YILjti6XKt8cA041ZAkps1FYiI5UXB4ZWO1NpQmd2ECVhfhYRMTIcOE3iQ06
         RWUBF9lOAouESGn2VaK28eSOMYxPIfmmtp+OD1NF08wRNH6yzFyZE4uPGPKz4pZw3u+x
         eaozicLhsabz/69Ji2WtJOE0jjdVTc470u9W5apHRmIr4ojhDTbLO63u/uiH5ffOgAxs
         Sc4R697m8Xqgz/jD0zAMs6vZ6HGEMdG0KTY+UrowujNX5lVQporng4m/tzNXszD6VL/k
         vwjg==
X-Gm-Message-State: AOAM532o6bTk3A1ZzXUk7pMX7nJFkMbKAuZlZ+8JkD9HOrETtmVlRu65
	S34LkdF4dJeEg1lsvJ2ou3hXapIDaABnTCeSJj9T64f2DAGmCf2tj1YCOokRVqEkCBse8khawkQ
	SOIYvURa5/Wdmd7c=
X-Received: by 2002:a5d:58c7:0:b0:1e3:9dfd:f835 with SMTP id o7-20020a5d58c7000000b001e39dfdf835mr15131516wrf.25.1645435008295;
        Mon, 21 Feb 2022 01:16:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzt57xUOUig6E1u8PWH930Qa2FL1Uu7uQCU7ux2Wu8vXmUiCxgIBGhJVfJ2PpAT1lTkHmm/Ig==
X-Received: by 2002:a5d:58c7:0:b0:1e3:9dfd:f835 with SMTP id o7-20020a5d58c7000000b001e39dfdf835mr15131506wrf.25.1645435008078;
        Mon, 21 Feb 2022 01:16:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b0037bc3effe27sm6860494wml.38.2022.02.21.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 01:16:47 -0800 (PST)
Message-ID: <08087ac52814b4479f0cc66be185879af3273ad0.camel@redhat.com>
Subject: Re: [PATCH v5 mptcp-next 0/4] mptcp: more self-tests improvements
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 21 Feb 2022 10:16:46 +0100
In-Reply-To: <e1a0afb0-ea3c-e6ed-827b-481960f49cd5@linux.intel.com>
References: <cover.1645134065.git.pabeni@redhat.com>
	  <7a175aba-a3d9-f2d0-fee8-5f616c999013@linux.intel.com>
	 <5098f08134c9cb059b32bcce363f466bd1f2df2f.camel@redhat.com>
	 <e1a0afb0-ea3c-e6ed-827b-481960f49cd5@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Fri, 2022-02-18 at 12:33 -0800, Mat Martineau wrote:
> On Fri, 18 Feb 2022, Paolo Abeni wrote:
> 
> > On Thu, 2022-02-17 at 17:35 -0800, Mat Martineau wrote:
> > > On Thu, 17 Feb 2022, Paolo Abeni wrote:
> > > 
> > > > This iteration tries to address the feedback from Mat on v4.
> > > > 
> > > > patch 1/4 is new and tries to address the problem behind issues/225 with
> > > > stricted RFC compliance
> > > > patch 2 and 3 clean-up endpoint management as per past discussion
> > > > patch 4 introduce new self-tests, as deserved the previous patch
> > > > 
> > > 
> > > Hi Paolo -
> > > 
> > > These changes and tests are working well on my system and fits with what
> > > we discussed on the previous revisions - thanks!
> > > 
> > > I was taking another look at the RFC and saw this paragraph:
> > > 
> > >     The MP_JOIN option includes an "Address ID".  This is an identifier
> > >     generated by the sender of the option, used to identify the source
> > >     address of this packet, even if the IP header has been changed in
> > >     transit by a middlebox.  The numeric value of this field is generated
> > >     by the sender and must map uniquely to a source IP address for the
> > >     sending host.  The Address ID allows address removal (Section 3.4.2)
> > >     without needing to know what the source address at the receiver is,
> > >     thus allowing address removal through NATs.  The Address ID also
> > >     allows correlation between new subflow setup attempts and address
> > >     signaling (Section 3.4.1), to prevent setting up duplicate subflows
> > >     on the same path, if an MP_JOIN and ADD_ADDR are sent at the same
> > >     time.
> > > 
> > > That made me wonder if we are supposed to treat this address ID as a type
> > > of advertisement which would require us to not reuse id 0? I think the
> > > answer is "no" because nothing in the REMOVE_ADDR section (3.4.2) seems to
> > > apply to joins, and it's also pretty permissive about not sending
> > > REMOVE_ADDR. We also won't be sending REMOVE_ADDR for id 0, so the new
> > > code seems safe in that regard.
> > 
> > Double checking if I parsed the above correctly. The main
> > point/question is: which ID should use additional MPJ subflows with the
> > same source address of the initial MPC subflow? My answer/what the
> > current code is doing prior and after this patch is 'id 0'. I read the
> > above as this is also your answer.
> > 
> > Please correct me if I misinterpret something!
> > 
> 
> That's part of it. I also wasn't sure if the MPJ syn could also be sent 
> with addr id 0 if the kernel picked some other interface for sending that 
> syn that had not been configured in the path manager - a corner case that 
> I thought had been mentioned earlier in discussion of this patch series.

I think now it's much clearer to me, thanks!

> If the outgoing MPJ only has addr id 0 if the MPC source addr is used then 
> that's definitely not any kind of problem.

That is addressed by patch 3/4: prior to such patch, MPJ subflows using
local addresses not mapped by user-defined endpoint would select the 0
ID.

After that patch such subflows will create a new IMPLICIT endpoint at
rebuild_header time will use an unique ID number.

Thanks,

Paolo


