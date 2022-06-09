Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E692F23
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654787023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqQj7KTWfpVR9zt1gPEIhApMMKhrDct5kfrEWz56c/U=;
	b=BDW8JggnBv2zgBxAVg+F+1BXJlSNJIUSaAOlkV1DcPs5youaAfy4iqWetFhqm0LUDBBDJX
	NwK4Qb9x1eU9h6PkC3izf96zFF8W1EVYNZwKI7OC62eMyzVWiUrnfp7Q/MTetNeJHECGnQ
	DUpXaV+iQYrjbASMdb7nMKRnSGbtVPU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-l3Ayrg8PPe-UlGgX9wpBMg-1; Thu, 09 Jun 2022 11:03:42 -0400
X-MC-Unique: l3Ayrg8PPe-UlGgX9wpBMg-1
Received: by mail-qk1-f198.google.com with SMTP id i5-20020a05620a404500b006a6d7a765d9so6524874qko.7
        for <mptcp@lists.linux.dev>; Thu, 09 Jun 2022 08:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sqQj7KTWfpVR9zt1gPEIhApMMKhrDct5kfrEWz56c/U=;
        b=ANG0KsUVcTXYOkf5s/Rgcw3kv4lTCS/S48ebkRuYb5hxMxxTSNZRx2XPDqYOriJvP5
         j2lJp2KiZuVc1sHPU5zDap9vcqxILqq0k3anlPdtJifP238AZdEzZDiVLEHBergkXspO
         VwTz9eJp2OSGF+WMy9iilCYZII5VkzCo/cFf9R1STxvmtOp9X3Kt4FY+2P3zB9I6L3cO
         mfSXsyKin2lkLixe/CUK/WTCMTYAOrgMIRKTrxbRvtETkmlKKjNDFSDU42EoCaiAs2lw
         k/DY+v/oRRepel6T8eI8d2pjoJ7iqNpaWE5GmA43WmVzm/Nv8ceSFPFh8SjWSL3WAWzv
         qYjw==
X-Gm-Message-State: AOAM531W8w75W2g8tgr1XLfRq49zuilHD/U93i+lABaSUKfr18RooyGG
	81PSQRX6OHWxgvT+wzEFBRi7Xlr5bVYtr+xgpKOuduYJvqndI/BlGcoaNxad4kxeB/QhMvyAb0r
	sBrd9njGqMda0O3I=
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr10616169qvb.80.1654787021554;
        Thu, 09 Jun 2022 08:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+rURe0kLNa5O8/Ghxkphz3N+UT00/QxEdcMRF0FeWFiDVWuv7VabT5zIwW/SiCwAa2T/ZmA==
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr10616131qvb.80.1654787021281;
        Thu, 09 Jun 2022 08:03:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a424d00b006a69ee117b6sm15946260qko.97.2022.06.09.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:03:39 -0700 (PDT)
Message-ID: <0bf29017a5a85214d3fe520288a731496c12df1e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 1/2] mptcp: refactor MP_FAIL response
 timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Thu, 09 Jun 2022 17:03:34 +0200
In-Reply-To: <ee1ab6a8d4525e7af542f84ad11fcca7a1e938e6.1654732564.git.geliang.tang@suse.com>
References: <cover.1654732564.git.geliang.tang@suse.com>
	 <ee1ab6a8d4525e7af542f84ad11fcca7a1e938e6.1654732564.git.geliang.tang@suse.com>
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

On Thu, 2022-06-09 at 08:00 +0800, Geliang Tang wrote:
> mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
> should be invoked only when MP_FAIL response timeout occurs.
> 
> This patch refactors the MP_FAIL response timeout logic. Add fail_tout
> in mptcp_sock to record the MP_FAIL timestamp. Check it in mptcp_worker()
> before invoking mptcp_mp_fail_no_response(). Drop the code to reuse
> sk_timer for MP_FAIL response.

I'm sorry for not noticing it on the previous version - likely for the
lack of clarity on my side: we still need to start the timer for
mp_fail response: otherwise we are not assured that the mptcp_worker
will be triggered.

Additionally we need some more care to manipulate the timer reset. I
think it's easier if I send a squash-to patch - assuming I'll have some
time for that early next week.

/P

