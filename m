Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178C33E8
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 14:36:48 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id sb3so21490458ejb.9
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=nSLjZuGAugw/X6hRpMLnRSRr1HlTIT6QST4F7Nl7jbk=;
        b=LYHXTqQ1XQxqCz5Uw5cdWFVoT5BEKQL1EbUYY0+/bLJYhMswIKnnioc6ktLf5LuS+W
         Kyc/y4+VBwlG3ybxczS4QOrYNeuZT/A3yP4Heq469cO/evUxmbNtUrkjOGwc2vYR+tOA
         8OSGfLagzXuIKTp91HP0Ih9QQHRyja+sQvQxkUKt2xqLWUJUpAFfabdbYmUrnQDwbxVb
         Bl8eQ6gB9diVzTpd/yD63HrLZwsgacgeBncAo2DOQTVgAO6H+LGgVNoiELwbhteU/+Bl
         R3LK690mbOjBJ3EGSpp2IA6UqsHHOsfn+ZjnMfpWT8rVlIBHvKygNsa5V3RFMJWKEFNo
         0HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nSLjZuGAugw/X6hRpMLnRSRr1HlTIT6QST4F7Nl7jbk=;
        b=dZAYa64ubk5GDebtozSvKnp3D2DYA0O8/UrG2u7Gp4rtZDV71YRTLACCZUn9Xp+PF1
         aQKbGUPuqoSdCk5UTT219YRhPmhUFhmwqILWYhm1ZCiSeFDZUQSe8kxiFSeEoPkfNTK6
         ri88IHcsYrUlTr+JnDiINFdbVvZygl6so09RaO5xg2EMExJdc1Bn5a3/oJObFF2Ry6Mm
         ftPrhSuU+blzme7g/QRXfY2+d+/F8f57RfVYJROJO5v8tKbUu9dXOZovG0gl07j+XGLK
         xwrzjsu7GeOcEzVt9wpuqKjgFSTbo5awL1v7aGqd4UhBvXX7fOwUqlbjvCPco6UJbdkh
         Lt2w==
X-Gm-Message-State: ACrzQf1xkO9rYJjiCGQLLfFa9+hsFLmUwSEXYh6IcmDChcynnkHdjO2/
	rXEHwPZSGYxLadFjaOma0c22LZrGMahTEg==
X-Google-Smtp-Source: AMsMyM6nI+Y2vVQqCtq48ShueG5ebNXzc0vXl6ElqJ8Qxt8Py1J3N83EP1aso1ph6XSPiU/efXaIsw==
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id hg24-20020a1709072cd800b0077664a81adfmr3040097ejc.151.1663857406983;
        Thu, 22 Sep 2022 07:36:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c8fc:7c50:6afc:66bc? ([2a02:578:8593:1200:c8fc:7c50:6afc:66bc])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b0078238c1c182sm1384329ejx.222.2022.09.22.07.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:36:46 -0700 (PDT)
Message-ID: <2eada507-062d-2bde-c65f-c28edc1dc0e3@tessares.net>
Date: Thu, 22 Sep 2022 16:36:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>, mptcp@lists.linux.dev
References: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 22/09/2022 15:56, Benjamin Hesmans wrote:
> The series only consider the sender side.
> 
> The sending part is less complex and even if it looks like we are
> converging for the receive part, there are still discussions on-going
> there.

FYI, packetdrill tests validating this series are available on GitHub:

https://github.com/multipath-tcp/packetdrill/pull/87

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
