Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBD2C82
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 11:36:53 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id s1so9544970wra.6
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WeKdlG2XzJtbNfH4iLrW0clqR/eZANUuc/2pedw/SAY=;
        b=MgxBBbGJ4tqBAR/kEr0FWDGu/XOV/GsX3gAMozeVjXQG48+VVNqwYIk+GQcw8H45Io
         ikvPWbKcHkv9KCws4fVnXhy2+wfpLC5VBjFjfEinUbDR5RFGOdU/N1h3qTtO7McALjzY
         04/evprLR4DcsKkz8Mwch/5F5MiDzRi6TajBocThWyMHL24Y5Gnjgcnj8IQ6ZlfRTWY/
         AHo/tv2ExijUxRN5Rf4e0Ys59iC1Y7hASGguRK/JBBg+Ttrm2MfpBhFoKUhaBopiyRfB
         9+rQMsR377hjv0zPU+44DcexSu26GkXiOLenIGNIPQPoJAYbMnxa/CsBrY0TfJwxBJq2
         T3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WeKdlG2XzJtbNfH4iLrW0clqR/eZANUuc/2pedw/SAY=;
        b=PvogWQZzVhnpLV0aHTO0sDIpb9oAmDl1dpU0x+FW+1pYIhe74VR3F2j5H9tZelN20c
         JnMW/lS0VdfieyomYMFq8LCqXPDc1F9oGU0siCF/QD2NT8QdysN89kY6cpDqbwt/27pd
         yKj1aFCGtX6hVLfAwJk8XNdxSqAQhXKM5YuKnv6v2NibvWjAID2MxwXDcJzTPxnxAb2P
         47RuBtnfEq1wx2xc2k1dcuw0vC+piprT7HHvWG42ejlgnP9EJC+2Z2vuCw8o6UHyLzoh
         k63mTY+akD+HRDljTmCk8Ei2Pm/6NGofK3udbHjZlkqxTLj56M7s1tLVQNKSV4/eQd66
         KtAA==
X-Gm-Message-State: AOAM531/0gdzoOk6cnV7PVNnpnoL3jQ8wahMwud7jKBlNk2EIzSahk3O
	54xvJ+UFz2sxNcZvGKhTuhifbQ==
X-Google-Smtp-Source: ABdhPJzyJDxE6sNLqJWSXbKjdujSdP5TddBFrPIRET/7HIqxSaDqHJDqH7Q1TZ9YdONA5Jc6Bxa3Wg==
X-Received: by 2002:adf:fb42:: with SMTP id c2mr3549916wrs.168.1642073811421;
        Thu, 13 Jan 2022 03:36:51 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id d5sm6336975wms.28.2022.01.13.03.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 03:36:50 -0800 (PST)
Message-ID: <92022e98-1414-5fa2-8fc6-2eb9278d6401@tessares.net>
Date: Thu, 13 Jan 2022 12:36:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
 <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
 <20220111034543.GA11026@dhcp-10-157-36-190>
 <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
 <20220113103534.GA16094@dhcp-10-157-36-190>
 <06dfb6e37c6eeb34f4f9e0f23086486072e9c6ad.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <06dfb6e37c6eeb34f4f9e0f23086486072e9c6ad.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 13/01/2022 11:52, Paolo Abeni wrote:
> Do you prefer sending a new version of the squash-to patch, or do you
> prefer I'll go ahead with that?

Small detail just to be sure: as you probably know the patch "selftests:
mptcp: more stable join tests-cases" has been accepted in net-next. So
we can no longer have a "squash-to" patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
