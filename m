Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9B3FF0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 16:57:34 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id lc21so4957467ejc.7
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BhJMW8pq3bzQNc45Co1/4BDo70HALOZH4HHOvKqOLus=;
        b=Kn0wXgByYG4WAEpu9f9m7XbMcDjR54266RCHTryyYMWayAw/46+akCkhnvk8OgXo9T
         zXQS1e02EXLg1Tf8Crez0KFrHseXSJ/zF1tGW6XJUvjRgx4hkmBlGZ/APyYd87I6peQ3
         2FcWu2/+1dQZ3a1qXl8FovGDMXBuQuOQfjKkvOqM0zlAyoiI9B5I+x7/Kdc4oIecTs5C
         LqnaZ18q66KsijuOl6E++B+a2JovNVPaeDug8TF3QCFuORdjDJjoZx/+BjC2fiIw2GeV
         YuUMbdLbMUAku2Gi/YB0/bdZAOwFj0h+6qFXr5CNdeMNMRKdEvoJ00AvFZYtTQeq8Il/
         6ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhJMW8pq3bzQNc45Co1/4BDo70HALOZH4HHOvKqOLus=;
        b=mXHipUoSjuzbs8gXIuj/Yraw9LqopT2X3CY8i6fOuT38CQh83tw9Djf3jsojycxOp0
         zWOOY5CmGz+8BdICeCD4jFfSZF2MBauTsXUVltm1ViUan1pE+6J1owvNNQXhwgveeJjJ
         ws5RLjyeVw3MEgU6UrI8sVRuEclio7P39l769SnlVhXhN2660pgN1SY70bURCKMqiTLD
         jQddOfSZ0zuY6gXQYLu1JsVjAeBDCOcV7I1XlH1rNCeNWrEqPpXYhIpyARdUZygbLcoa
         vaduXXKU25V5vbazervr9TsFmxBwSyPugyHzfIZr5YO7pl2GK3jdllF/ZQzmm8L2F5tb
         sGJA==
X-Gm-Message-State: AOAM530GHMy0XRxdNU6HPwIjPS/AfpKpY0ex6yhLrIlRjLX3No2OrrvI
	uSfMhztjvwDDsm3r/4gaUaxqVrjCP5N8Nr8L
X-Google-Smtp-Source: ABdhPJzgFl9NebjulQGYDFcMzNSOLzY3aRBK4ZoyS/BivHIxOPvfxEerGrrDphYs4gY8QADFcR+1jQ==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr4516299ejc.247.1631206652558;
        Thu, 09 Sep 2021 09:57:32 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id dj25sm1399532edb.51.2021.09.09.09.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 09:57:32 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: stop relying on
 tcp_tx_skb_cache"
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <a4b897af7a6c7dcf4258d2ad90ddb5a676250ea1.1630921280.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <e07a1102-9caa-c6c6-0931-55d9f3fc504d@tessares.net>
Date: Thu, 9 Sep 2021 18:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a4b897af7a6c7dcf4258d2ad90ddb5a676250ea1.1630921280.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 06/09/2021 11:41, Paolo Abeni wrote:
> A small cleanup for the tcp_tx_skb_cache removal: we don't
> need to check for skb in zero win probe (matttbe)

Thank you for the patch and the review!

- e4bb25dfcd2d: "squashed" in "mptcp: stop relying on tcp_tx_skb_cache"
- Results: 5fabcaa6857a..84da6403b775

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210909T165704
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210909T165704

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
