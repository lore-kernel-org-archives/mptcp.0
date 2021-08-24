Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2E72
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 09:38:01 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id cn28so30635453edb.6
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O5oUnylfEjNpYTA0feC2+IGydrYeZTj4rlkj7JIpFDE=;
        b=ZJUOCWX3xPR2uxj9DOnmt+Tj0Vp6t3oP5ssf2bDgcozPGkRNVa/pjGUjfkAPpoU24P
         KO8B0uz9ND14q9CzxJtzkISnwuRAo5eHkijJEvgBE31djaUNxc1bn3TQNvYljIL/8MeM
         5nG/EqIihSUFPSRBw2u/gwKkhwOTv/9cC7cvs2FLBy/LKl//1qwAIsdGD/HeWVV7rjue
         ESLjitcEBRvgFHoJBwr4KW7ENGtqWRSSMRq6uBkq+2W12dKJOdBI5OR+Nhg78hTa7K4B
         O57sudwOE3b+7CKmyRa5Bhp063j3RG9LeuTeGubMHzMI372HXUZiyirW0Di96vGIIJYK
         2uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O5oUnylfEjNpYTA0feC2+IGydrYeZTj4rlkj7JIpFDE=;
        b=A+t5+pauDnlyucyvd3XpQXMYPCae+uSdunXDXE/k6ySIL3nNX2Z3FYfvBS8GIMjO0d
         6Hd5czTXvv779dWtju99Ox9af1ynsA+KseBvknaTgQ9KKGn6NxmaWJVvHTSWbVM7NFVX
         JpNRPm3vV9y0j/t8TnG/cpC+jTJNxXJiclEmwYuoqBZnVbtHoaIbCOa3ImTeOM4obK2E
         GDt5mnM18CXZgLsKuWrHh8K3qJhnKoMQl04pvS5T5Ljfh5ZbJHZYc0yELCJqlwJSgIRD
         JzDkYE5RdUgF2hEv2ALObKcg63ilr1PZAS6QR8Sqq4L71vI+Vucjh7ctfByEFtTVEorz
         nUAg==
X-Gm-Message-State: AOAM530Ct/9Pwn625byeW81vUSO/o4tim4nodbekoJETXhXXMCDyKt1e
	/DxbizHZt4ROB/2iAfXI1d2UDaFMJzxEIgREmtg=
X-Google-Smtp-Source: ABdhPJw2VIp8+f81gBRnHE6lI23Lf9EE882Wnh5W5Y2bLMaKE8055SbnQiYaxf5Y6Efb59qxjn6w2w==
X-Received: by 2002:a05:6402:1d19:: with SMTP id dg25mr41787918edb.153.1629797879392;
        Tue, 24 Aug 2021 02:37:59 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id e22sm11280921edu.35.2021.08.24.02.37.58
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 02:37:59 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20210824084751.3490436-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: clean tmp files in
 simult_flows
Message-ID: <54903a4f-860b-93f4-ca7d-2dd3bbeddca6@tessares.net>
Date: Tue, 24 Aug 2021 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210824084751.3490436-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 24/08/2021 10:47, Matthieu Baerts wrote:
> '$cin' and '$sin' variables are local to a function: they are then not
> available from the cleanup trap.
> 
> Instead, we need to use '$large' and '$small' that are not local and
> defined just before setting the trap.
> 
> Without this patch, running this script in a loop might cause a:
> 
>   write: No space left on device
> 
> issue.

Thank you for your quick review!

Now in our tree:

- 5f14e01df498: selftests: mptcp: clean tmp files in simult_flows
- Results: e91aa69164c2..e4be38126ede

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
