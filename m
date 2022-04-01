Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D87B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1648825420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCCuGajUHFsNstGkb0stxBNeP57VskD9jYfiO9uxC0Y=;
	b=VA3DZrLT589yLHKjvYh2NvROOqv5EN8vK214PCen1gkR4yRgvM6n1fPVS/mZoaN1nGQG8x
	fYo+ScepSV4pG2ffqO1BR3dzZMlgqT5wHUejFvdkmB194RNccEsNFnqGErh0mcU9YD0Zpg
	BvFE19mIT0LdyDLCbbThKTDiqD69Y7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-bJi4Y9WmPl-KVZ8U04jEoQ-1; Fri, 01 Apr 2022 11:03:39 -0400
X-MC-Unique: bJi4Y9WmPl-KVZ8U04jEoQ-1
Received: by mail-wm1-f69.google.com with SMTP id h189-20020a1c21c6000000b0038c8655c40eso1280975wmh.6
        for <mptcp@lists.linux.dev>; Fri, 01 Apr 2022 08:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FCCuGajUHFsNstGkb0stxBNeP57VskD9jYfiO9uxC0Y=;
        b=EInmgvaZR1GGgOkaUfeTFvx7VujvWJT2ySNsBKeACh0qb75E+mnTyAAi1sdm3Ar3AD
         xcOJQoBJbmHJ00hRnatrT7gVFfD3ynM5jGutLC2bDpgo5/nZxzZ6rtFvmRHktptbM+TS
         G5+I3mfuQ1+7wakMTovC1griG/HSRycUPZUZdVo/zOH6Od1EVAEvUMO7TT0PLldTm3ab
         neFUqPqutLmKn61kLN1//Vr6d87i1pSof2UceImxOzQh64qIyR13iQyulaVHRa9yYAmp
         bXG5/c/Sf+GfYd4BUSuXHHd2+el3qoQ6krAWHrwN9Dup7oLvcrM4wTqeJdTXRMju4+Cm
         f4QA==
X-Gm-Message-State: AOAM531h6Bj58ElZowkSPRl/oRAn+p5f/zugwhCxS3X+dXdvbu1aPk8j
	CBafjieIn8fzf37OpxVvPk4Ed4H9Ulw2DXZ6Z1Ogrppgw82Eb9vA893j9WXF9/aEnAAOMp0vY1b
	N6fJmLu0YfGdDtjw=
X-Received: by 2002:adf:f609:0:b0:203:f716:948 with SMTP id t9-20020adff609000000b00203f7160948mr8592737wrp.77.1648825417885;
        Fri, 01 Apr 2022 08:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz950wDfp2cTvVQQdCWsbkp7Flv/WaB2npWCJqOAZOBWJ1Xj7xXuC0FGOuXvNfuxOc4G57Z4A==
X-Received: by 2002:adf:f609:0:b0:203:f716:948 with SMTP id t9-20020adff609000000b00203f7160948mr8592719wrp.77.1648825417599;
        Fri, 01 Apr 2022 08:03:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-142.dyn.eolo.it. [146.241.243.142])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm2432271wrg.70.2022.04.01.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:03:36 -0700 (PDT)
Message-ID: <c71821482e4eefe5a5f6067f38192e95bd834ba8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v6 03/14] mptcp: read attributes of addr
 entries managed by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 01 Apr 2022 17:03:35 +0200
In-Reply-To: <20220329021437.1196552-4-kishen.maloor@intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
	 <20220329021437.1196552-4-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Mon, 2022-03-28 at 22:14 -0400, Kishen Maloor wrote:
> This change introduces a parallel path in the kernel for retrieving
> the local id, flags, if_index for an addr entry in the context of
> an MPTCP connection that's being managed by a userspace PM. The
> userspace and in-kernel PM modes deviate in their procedures for
> obtaining this information.

I'm sorry, but I was not able to give feedback earlier. I really think
it would be better do the 'if (mptcp_pm_is_kernel(msk))' in a thin
layer, and add the new code into pm_userspace.c

e.g. this patch has a relatively large diffstat because quite a bit of
existing code is just re-indented, with the proposed schema that will
be avoided.

Thanks!

Paolo

