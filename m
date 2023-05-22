Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1073BE45
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 11:17:47 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3078d1c8828so5675634f8f.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 04:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754266; x=1687346266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa4yoMYUVe+znIbvpLWfQiYJw5wxHmKTJsraqwbniC4=;
        b=E64XCMGsy1RATY0nOwhGuIfTcsfDTZQTBY7qE7ZBDNhH8c92Nw5fVpCA1KdBz9/zyO
         MXschwqWFrWhbz2i9k4PrToMTtijYMr/kp7gPGxL3RMrMiRb53kiVg6OGijXK01ObmoQ
         V1WCSq8/AHTeGMQLTpA3puvFMVkqReRa7CGMt2Q/RmgDrWouO5ekG/AGXbnTWR+kflp6
         /5WizDjcfTFfZ2Y2CJlLQbyUT88jZmcTwVqP38RFylS/ouk+ALCQKnTmgPhPiFwdi3o3
         76h9yBLc6hBSwS5M/7TCOXzHwhyBrm/lQdql5F4BvvkjOpglS6JsuAnZumljffVvq8GY
         mXyg==
X-Gm-Message-State: AC+VfDw1t08Yso+ivRKGaiQFgY86zZ44Uo8lENOZyBzhCYCL+l9tImh+
	YohUoHU3u543KdROu56Qn+iz/1CoMHA=
X-Google-Smtp-Source: ACHHUZ6enL9N/27CJKfQFexPE0EA5khiNUGyDQCe5ziVHAiNGRluBEzHjQr14j2UULz8G+chObJrqA==
X-Received: by 2002:a5d:43c8:0:b0:309:566f:3cd with SMTP id v8-20020a5d43c8000000b00309566f03cdmr6450312wrr.6.1684754265881;
        Mon, 22 May 2023 04:17:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003f42e008c8dsm11232332wmi.44.2023.05.22.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:17:45 -0700 (PDT)
Date: Mon, 22 May 2023 04:17:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks: Tests
 Results
Message-ID: <ZGtPV9VvAhqDXk8e@gmail.com>
References: <20230519135821.922326-2-leitao@debian.org>
 <68711854-61ee-3892-ba5a-136c73b8aff0@gmail.com>
 <7f3ef790-1cca-5cea-46f8-3aa838da59b7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f3ef790-1cca-5cea-46f8-3aa838da59b7@kernel.org>

On Fri, May 19, 2023 at 11:03:04AM -0700, Mat Martineau wrote:
> On Fri, 19 May 2023, MPTCP CI wrote:
> 
> > Hi Breno,
> > 
> > Thank you for your modifications, that's great!
> > 
> > Our CI did some validations and here is its report:
> > 
> > - KVM Validation: normal (except selftest_mptcp_join):
> >  - Unstable: 1 failed test(s): packetdrill_fastopen 🔴:
> >  - Task: https://cirrus-ci.com/task/6416256383844352
> >  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6416256383844352/summary/summary.txt
> > 
> > - KVM Validation: normal (only selftest_mptcp_join):
> >  - Success! ✅:
> >  - Task: https://cirrus-ci.com/task/5008881500291072
> >  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5008881500291072/summary/summary.txt
> > 
> > - KVM Validation: debug (except selftest_mptcp_join):
> >  - Unstable: 6 failed test(s): packetdrill_add_addr packetdrill_dss packetdrill_fastopen packetdrill_mp_capable packetdrill_sockopts selftest_diag 🔴:
> >  - Task: https://cirrus-ci.com/task/6134781407133696
> >  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6134781407133696/summary/summary.txt
> 
> Hi Breno -
> 
> These appear to be false positives that are popping up in our CI on other
> patches too, no need for you to check on them!

Thanks for the heads-up!
