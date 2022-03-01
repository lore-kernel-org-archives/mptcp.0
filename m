Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261417E
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1646126133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSfKV2fX0YB1voGaAx6i6YhdnORuKIed1kOgMDFP29s=;
	b=hBLNMuMypF0zVVMfD5O71PvnJLUsgMBaLyElIFeLI30/g6i8a0+zGltLX7+YprZYNWn0l0
	YETwp723WIt5yFE5wkHD4RLBGFfgTJOkcciwYlthSMbUBDO3JAm9palDU7mWeU4QNzkejt
	chm7Qmpx1MlwoZng7myRTKQR9ukYa7E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-pMLTDXEUNKyCSufx6zg9QA-1; Tue, 01 Mar 2022 04:15:31 -0500
X-MC-Unique: pMLTDXEUNKyCSufx6zg9QA-1
Received: by mail-wr1-f69.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so3013541wrw.9
        for <mptcp@lists.linux.dev>; Tue, 01 Mar 2022 01:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QSfKV2fX0YB1voGaAx6i6YhdnORuKIed1kOgMDFP29s=;
        b=kl1B+zR0+CgnwHc1zGzBajpfCh622sI58po6liOj8H3X6BcL+9bpUk8ObBMUdM7K8s
         bBVKtjsrvTjSBWf8oK07+pPJQ3yDJfx5KwKaQpxvTujboa9dZgNJlmFCbpcja7nxnIVT
         1GoTQ/QsSDyDDZE40B1ysviJG5KfMzhRP/S6zM9u1l69Pt8wnefOTx4qz6YiRSV52I1p
         0L2703+UJK7dK/ZrcO6mLU1VX5mXdhX3so1tpKfOFqFEMDblV6RNjO0wj/9eH6KbkjUb
         B3dGHqeMg66NfzL8AGWOJEqQ1wypzUOwR5RaCBXayNFqNaODvaU2bOhpH14hrlVAOfvH
         B6gQ==
X-Gm-Message-State: AOAM533OkZpM+YsmntCczgFEcbTIVxVjxNs7RnJaoDYw5m4KgHxtGFB/
	2ksntdqPikLwl8jd36Qn/QYLKxjTb6OHUgD2jjQQjUWHvgIEVTDjH/79CWpTGe3hog6iDegBzLd
	kNvn/S/5SlVIXr8E=
X-Received: by 2002:a1c:c912:0:b0:37b:e074:dfcb with SMTP id f18-20020a1cc912000000b0037be074dfcbmr16226239wmb.161.1646126130230;
        Tue, 01 Mar 2022 01:15:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysXdRjUpwLtMH4GpjzIuH0G1TH02rvBBW/fRtgi9l4Ud8sNWuIJ+TV+2cf/jhnKn/DVUamhA==
X-Received: by 2002:a1c:c912:0:b0:37b:e074:dfcb with SMTP id f18-20020a1cc912000000b0037be074dfcbmr16226224wmb.161.1646126130001;
        Tue, 01 Mar 2022 01:15:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-142.dyn.eolo.it. [146.241.242.142])
        by smtp.gmail.com with ESMTPSA id x13-20020adfec0d000000b001e31279cc38sm12952654wrn.11.2022.03.01.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:15:29 -0800 (PST)
Message-ID: <67e97880f72920d45e6ef9dbb55b7e626363a28f.camel@redhat.com>
Subject: Re: [PATCH] mptcp: send ADD_ADDR echo before create subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net
Date: Tue, 01 Mar 2022 10:15:28 +0100
In-Reply-To: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
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

Hello,

On Fri, 2022-02-25 at 16:53 +0800, Yonglong Li wrote:
> In some corner case, It may receive ADD_ADDR retransmit package
> before created subflows done.
> It's more reasonable to send ADD_ADDR echo before creating subflows.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>

The patch LGTM, and beyond fixing some corner case it looks like a nice
cleanup.

I think the changelog could be clairified a bit (even if I'm possibly
the last person to give this specific kind of adivice ;). What about
something alike:

"""
In some corner cases, the peer handing an incoming ADD_ADDR option, can
receive a retransmitted ADD_ADDR for the same address before the
subflow creation completes.

We can avoid the above issue by generating and sending the ADD_ADDR
echo before starting the MPJ subflow connection.
"""

@Matt could you handle such change while applaying the patch?

Thanks!

