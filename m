Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABF70
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 15:16:48 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id i13so20838406edb.9
        for <mptcp@lists.linux.dev>; Mon, 07 Jun 2021 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V8VDhk5K30TzGkELr6kt8GpMthfv1OYqrLYr5BGM4fU=;
        b=E6kH90CKjL3bVlOo+HiKirBx5mDfBWJ/vunrX5ZO7Vg+ywQasRY7sEAWDXEHPZ/O4L
         cLsE7z9jATgeSmHrjNnMY55fO0tirwalFjpHiVISHF+Ra7/j4sIBxECR72IBoyZSDHlu
         /AiiCU0zVvbPUoZSuMwoXDZOmO2uujboVKImVZnNKfdpBoVjiKCEh/1XfBDNntx936cE
         xsJLlw1Hn3LzUfyFpjGzvcjbb916vEOvOXdEfJI3Q4IKoxQBsOyL8hw0GvMe3ZjKgQ2z
         799GJaM3u8c6NT/Fj7MplRBo17UWvyACwN1f/y05OLt9dJ949LyPxjDx89DfYItoUWMm
         a/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8VDhk5K30TzGkELr6kt8GpMthfv1OYqrLYr5BGM4fU=;
        b=d7hKVRUu3rD4LFmR+4wvv7wuzlsp++H5eh4YkTRwZ7Q14gEHSDaFuvYl5q2ohBp18f
         YYIOWtNom1/fYEUmSP91XGQbi2+m9mpef/TdVK8XbjZkeDii0m3XvSnkRtmth9g7an+2
         Xv9AsZ+HQZmXc5iU3aN4naAp9Jt7mqKWmq1bAXcNta8w46JYcxBDKVn2Tb9Igefm+1vm
         2ZXcVtVnCH/XnfAU3S6lN65oWGzJnHidua8afp14f4ecbAY2JVY/Qzv4rJITI+4p5Ac2
         fKO4XMynax+v75GHZIsALTMpOPM5RqIB4ME1YVKfG4Ua81D+REW81zD0x2qGdEYnNdmq
         s5LQ==
X-Gm-Message-State: AOAM5310CgyPWFHUP2WpWc63AMWbxkWwhg5L3Ipx+yYHWYt5XcOlcy3d
	zJ2S6f+bA3HYeVJFQ667alwLAERjoLDMnSH8
X-Google-Smtp-Source: ABdhPJyl7aQz4R34PyI8DhG85hL36N7RAQi4AVlFyj1aPJ8Ga0olVJDNlUIyWG7nH5fiG2pvAxu5yw==
X-Received: by 2002:a50:bec1:: with SMTP id e1mr20673908edk.116.1623079007289;
        Mon, 07 Jun 2021 08:16:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.155.103])
        by smtp.gmail.com with ESMTPSA id qq26sm5409177ejb.6.2021.06.07.08.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:16:47 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next] mptcp: add MIB counter for invalid mapping
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Maxim Galaganov <max@internet.ru>, mptcp@lists.linux.dev
References: <9ec7261d647d0360851f3029ead0b46d38ccedd7.1622733220.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <35432666-1a22-0fd3-3e17-a0fb4f2a509c@tessares.net>
Date: Mon, 7 Jun 2021 17:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9ec7261d647d0360851f3029ead0b46d38ccedd7.1622733220.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 03/06/2021 17:16, Paolo Abeni wrote:
> Account this exceptional events for better introspection.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree:

- 57a908ed79be: mptcp: add MIB counter for invalid mapping
- Results: a4f45379c78f..605dd61e1d4e

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210607T151624
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210607T151624

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
