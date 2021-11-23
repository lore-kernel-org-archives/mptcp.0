Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149B2C94
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 11:24:56 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id r25so53717120edq.7
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 03:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=eYJWfjFdzrApdJRYd2/DK1EcEVn80cHhBS7hjtmFpkA=;
        b=YYJ0STURSJo6k7KCbJkOK7ddLUOEkuGE0qcyzb8xy3+fU/yJAhpRDAeJxNsD7smEe6
         oKCZrjVa86PSbxqvzO/XEU91yGWLRoDt52K7eslbIQQzLX3Rnbr8F5qUB39zEgwUVTmL
         cN4j8IeEijA3jI8TJLNBKfOSa/33jbBalg91lbK887PzUAMUJmdgTnNC3YNNO/HFmsn5
         Zm7MOZ0sj1noT4aq/2w8hygtx4cM/2Eilzb48TbhM/WNmnhNjWZ+Xa+NTxLHhajhlWj+
         Z6dG2DBMZ55NpwnyNqA+WPIgETcRjmnfnC+XpPlVfMD5+cWIfXiWUO+fz6QmP73+iAtp
         Z2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=eYJWfjFdzrApdJRYd2/DK1EcEVn80cHhBS7hjtmFpkA=;
        b=sQpOJ1kINEIt97vna7Irz92aKPd6bUNa3OhngKMhzKDwJLg0nhljWqhZohcglN2XuD
         T1RrmH97TxbJnNZv7o1UTdE5/XZ7toc+3bdSfbADsWYnsPS5bENTgopebf0xjvhX8W7t
         OKoAMJM/BUok00p0TMt/w5HOAlIX3RiAQ5jy1b6wKzepOGl5HlczgejAXIZENp1GMKt7
         mDDZx6DFbNcf7aIWGsjQk2YWDsdHAH2n8sdKlArAZGEOh4NDUgARVssRQHiS6LxNJAJR
         C7aQZ8riLNGRvsSoeC57MDsKDxsXFGd8B/7baYKSDkgEvJx6FjEqaD87k5MdScNuOC9g
         Ysig==
X-Gm-Message-State: AOAM530sTdWEp9CZEt03HbSgScpFeZVSD2Y7WZt8qKzaXMRQTHYsbDwo
	J+SxVrxxROpWKYgziqJhOod56MCIeNKZWH7u
X-Google-Smtp-Source: ABdhPJwxYVcxMlEFhNvB9Jxq45RYzMqnVvTu7+4nOysuqfXVirNkcO6/ScxOhvvoJWoh17/wFEAFxQ==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr6658515ejc.216.1637666694726;
        Tue, 23 Nov 2021 03:24:54 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id e1sm5556118edc.27.2021.11.23.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 03:24:54 -0800 (PST)
Message-ID: <c66f2448-f0a2-e222-e9ac-2d3c5f7589f9@tessares.net>
Date: Tue, 23 Nov 2021 12:24:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: selftests: mptcp: check IP_TOS in/out are the same: Build Failure
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20211122152651.28466-2-fw@strlen.de>
 <fb1fd660-ad41-92c3-bb3b-2e0aad740dc4@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fb1fd660-ad41-92c3-bb3b-2e0aad740dc4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 23/11/2021 12:11, MPTCP CI wrote:
> Hi Florian,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.

My bad, I applied the patches manually because Patchew was not able to
do that but I applied them on the wrong branch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
