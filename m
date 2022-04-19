Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97698ED4
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650364804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rp25Kb3a3ATITi35/8EKDvsd1b28eEnsqtQgwyaofA=;
	b=feihfnm2icNYt0iQOrusRts2uL06lAEI39tncjt6w/bU9sLJ3e69tFaD25fZcrQgN4de+N
	pc0TnX3Gyy6SSJODYX4KW9acEj4g71fKaK2RW1CcSv3HnCMf0vdPMti67wjnQHpbnTZZod
	gf4yAQnNmhywrg25vgMRMQjcZG0iaAY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-j-j8T8qkMkyBC4q55vp6Ag-1; Tue, 19 Apr 2022 06:40:03 -0400
X-MC-Unique: j-j8T8qkMkyBC4q55vp6Ag-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1051077wmj.0
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 03:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5rp25Kb3a3ATITi35/8EKDvsd1b28eEnsqtQgwyaofA=;
        b=7ZvT/4374tc23PordfjfzJT/PFr5Gm8Kp/NJq2KDzzdeQSNVos2aHv4X0n52Sxsi+Z
         f0oexI787q3iOd0sVW1VJ/ZB0OAP0m7RAF6T42ymga4D3o4oE7syIR6xIhFWW5eOtDKg
         uepIIiRtyG1CF0L0R7o3yYScllFpkx9OSVb4FxxPGE/EZnSO83mi4V7PXjvzlm3cwBWh
         cCEhKE19tiifDMIKynMRgcoPRArIwc8G98474hIyA/T4xyAw7hZHCkjbMbYbEPm8byqZ
         +fpGqVRMgB5BChjPAdvD5lPYo1bfj+EY+8Y0wuOinkoB1zcZkfmtMGurxYLUCJ6zrHBJ
         HbJQ==
X-Gm-Message-State: AOAM531OcJ9lV+2pPZO6V/+vPhHtOSQfUJCNQPlvRLUfTIfkVtv1/Z1P
	BFI6TDR7ZGAsU+L0hP1Se3g+CIKLq8Hw0HWqMfYclQ6TVMHfFQ79U05AIeZTBs/uO0B8/bIJp6m
	wVIB9gZKD4Ml4rF0=
X-Received: by 2002:adf:dbc3:0:b0:20a:88bf:6d83 with SMTP id e3-20020adfdbc3000000b0020a88bf6d83mr10842792wrj.301.1650364801698;
        Tue, 19 Apr 2022 03:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI7f2r0YqT2ptTZm7YI0DyYBmo9mPopRdlW2BBFJPWJTazZ8HbZLEh85t33iqMSY2UeWmwog==
X-Received: by 2002:adf:dbc3:0:b0:20a:88bf:6d83 with SMTP id e3-20020adfdbc3000000b0020a88bf6d83mr10842781wrj.301.1650364801480;
        Tue, 19 Apr 2022 03:40:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600015cf00b00203e324347bsm13746104wry.102.2022.04.19.03.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 03:40:01 -0700 (PDT)
Message-ID: <5d1b404c9bb8ee05b15aa0fe516765a981af9833.camel@redhat.com>
Subject: Re: [PATCH net-next 4/5] mptcp: never shrink offered window
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 19 Apr 2022 12:40:00 +0200
In-Reply-To: <c5a12ac8-563c-61e1-6d9-fbe318f6b8ec@linux.intel.com>
References: <cover.1650034062.git.pabeni@redhat.com>
	 <1f9262fde4d50db2d9d5c46254b823fd3e451465.1650034062.git.pabeni@redhat.com>
	 <c5a12ac8-563c-61e1-6d9-fbe318f6b8ec@linux.intel.com>
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

On Mon, 2022-04-18 at 17:29 -0700, Mat Martineau wrote:
> On Fri, 15 Apr 2022, Paolo Abeni wrote:
> 
> > As per RFC, the offered MPTCP-level window should never shrink.
> > While we currently track the right edge, we don't enforce the
> > above constraint on the wire.
> > Additionally, concurrent xmit on different subflows can end-up in
> > erroneous right edge update.
> > Address the above explicitly updating the announced window and
> > protecting the update with an additional atomic operation (sic)
> 
> By "(sic)", are you saying the new atomic operation is consistent with the 
> use of an atomic write in the previously written code?
> 
> I'm accustomed to "sic" meaning "there's a misspelling in the previous few 
> words that have been preserved from some copied text" when I encounter it 
> in English text, so I figure the Latin word may have slightly different 
> meaning here!

TL;DR: I guess we can drop '(sic)' from the commit message.

"sic" is the short form of "Sic et simpliciter", literally meaning
"it's exactly like that", often used as you noted to declare that an
apparent typo is actually intended to be there.

Here the above usage is extented to generally remark we do not like
whatever stated proviously, even if it's exactly like what we just
wrote: "Unfortunally it's like that".

The latter usage is somewhat e neologism due to the assonance with a
comics book onomatopoeia ("sigh")


:)

/P

