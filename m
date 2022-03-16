Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7782F2A
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 15:58:04 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id r23so3363680edb.0
        for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GHrDkHiI0WDlcIFquK8uu8odxjAgmb4HwmDgHtZoh7g=;
        b=NBkh9bJQub6Jk5p3ypVzfJB8Kj6NFzV7RCmuS7lDl9XPV4lD4qGtTs23bIt5QzndAe
         KBlACc/tfIGcX+ZR+d0LqUu9/dYh+kqAVR8cPMMYvle/vA4rZe6yy205GFqb4KKwKErl
         F7w0FRVBt4TcIaoA5FcL9OT18YTJR8z/d3AJqxmfGo1Dg1xObxmhXc9gnMYZMsnzm45E
         3FxvJ0uSXojYh8sRqXCbTQIIBghB+lbolQSLR9KZPVosTnedt/80x1rnshUZELwCy1t/
         hk5xhWLhIUl7R97ZHps9+bXfa/kA5TREjdjjXCDvGRurdO18u1iNSSVNBWC4l3UbOUrQ
         D4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GHrDkHiI0WDlcIFquK8uu8odxjAgmb4HwmDgHtZoh7g=;
        b=HqtXwrzowMvh3tuWMzBd3t9FNFxel+bgzH0y7xhqt4hQ7yTdAEk5k4lFtGkHNgdBr3
         Tnx6qW5HNwTosA7M2ZbqaLHq0txN+Cn7GvwmoYcsZyO7fb5IOvBAoEKlBSxVCZ+sWDN0
         Mt6WAbVIl4QtZU0mjaPHXqOCrSGVsY8XXGUPmYl7/MGKDUOSn1JjyJTo2I5/oNIU5QSU
         PWtM3y9CWwOlHaW6/1+tiMOD/MSIcAqJIJT+9nbuTCj0JfkWCl7L3BEHJlZF1dop2L1a
         fCmndDY40gfGXoc1usQBuJrr0EyodtpcGoIz/VPzqeT+/Wtwt5xwXtQVAG0cg2+2KBJ0
         jOaw==
X-Gm-Message-State: AOAM5316JlZfgz86xYdt0LbVGTnRFTYsxw1I08XNFPBBhKqbg4j3tAwO
	ihVHB+o1g+DhT3em6yyIgM2DnA==
X-Google-Smtp-Source: ABdhPJxljgEeNMb91CJVUlVclfQKNT30LxhyHAppQmcAPgOg8aydehqM0ROw6cVPiki0CsOC6BVncg==
X-Received: by 2002:a05:6402:2692:b0:416:c49a:2a2c with SMTP id w18-20020a056402269200b00416c49a2a2cmr218080edd.72.1647446282364;
        Wed, 16 Mar 2022 08:58:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c80e:ceec:7bc:494? ([2a02:578:8593:1200:c80e:ceec:7bc:494])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm1143372edt.81.2022.03.16.08.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:58:01 -0700 (PDT)
Message-ID: <032da72b-e0f9-ca70-622b-3429dbc1d494@tessares.net>
Date: Wed, 16 Mar 2022 16:58:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mptcp: Fix crash due to tcp_tsorted_anchor was
 initialized before release skb
Content-Language: en-GB
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
References: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonglong, Paolo, Mat,

On 09/03/2022 11:20, Yonglong Li wrote:
> get crash when do pressure test of mptcp:
> 

(...)

> 
> in __mptcp_alloc_tx_skb skb was alloced and skb->tcp_tsorted_anchor 
> will be initialized,  in under memory pressure situation 
> sk_wmem_schedule will return false and then kfree_skb. In this case 
> skb->_skb_refdst is not null because_skb_refdst and 
> tcp_tsorted_anchor are stored in the same mem, and kfree_skb will
> try to release dst and casue crash.

Thank you for the patch and the reviews!

(sorry for the delay due to the reworking of the git repo)

Now in our tree with Paolo and Mat's RvB tags (and without typos
detected by 'checkpatch.pl --codespell')

- 9f5c50f2e2b5: mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb
- Results (net-next): 1d99000bd70..b0d3123bdf0
- Results (net): f8a0df6cce2..153502a63ba

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220316T155243
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220316T155243
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
