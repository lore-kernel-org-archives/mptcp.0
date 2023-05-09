Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28417FE6
	for <mptcp@lists.linux.dev>; Tue,  9 May 2023 15:18:50 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so11394948a12.0
        for <mptcp@lists.linux.dev>; Tue, 09 May 2023 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683645528; x=1686237528;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPf4cOfIg2BIlex765zXwi137rooYQ/EgU35VY2wAHg=;
        b=B2AxrTChlyHNqJnHLb8CCxDcVLUYlljY2jNyJaYa042AB3IeqMyCfdthXQ5voA93n1
         NNUGDnJSH+pYShRs6ZdCvxiqBxSYGUVZaVIdkFNC08YNiTDq8WWIWORBJEFB8LL10J0G
         7v5madtG7TQUPiO8dUDo4JSHDNOnAxh6DFINgfOmWrExTQ/mFKo1mwHvhsBKhTE9B5W9
         ijtshGRgToStz6h/kG2E3xxHPiq9kg3zkaUmKA7m8aR+sHGBwOhjZmx8DTQZngTd5dpQ
         BXBvS7LpNxmq8q9dTIul7lbNlEuvbj/hhVNteBIJiqdKGIZjhscHHo24vjqBnGKP844Z
         x6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645528; x=1686237528;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPf4cOfIg2BIlex765zXwi137rooYQ/EgU35VY2wAHg=;
        b=TRSJNNKTjUWhGp2Y7CRHjAF43yJveAcAzbMFBtw8EFsYCY/VRuEPJ+cZCWzFYOCmQj
         QML+HGQf9sj1lbVWKnWWigNpOcJLsSNs0QOWE17F/cU0AG1i9ZU7hejF4clPQVlSLhrb
         R7OxE2TXeShJQ8v1Fs26FIP68GnTc1AacMiEi8Noz8j/KsOjbP5dDwLow9Y/F9uA7ksT
         1AKfbJ9tzP5Jvt0w+mZqZ8WRqyfWB/IhQZb5nZBd2pTnOpgmZqCjeXj97Vx4eq/uMQiM
         OywvMZqMvnfSPPogbt1s/RIV0BilqNqU8eP17US9/7FyiGeksdyXZkS6xjqv1gRMxTFs
         DZwA==
X-Gm-Message-State: AC+VfDw5sd0vQ/1wvhyuSXijB7APJBASrHVsiaeEU7A9BnQ022YXETdS
	kA/fZoZ4A+fOCXTCelTe3NvZc/5qd1CnJ1WEKRqyvw==
X-Google-Smtp-Source: ACHHUZ58FJmGjDRplIIhK8nDciJNkjbavULE8ANFmRhXaShJnS8DlOeVCHCLQ4UAcsGsA3hVY878dA==
X-Received: by 2002:a17:907:3f25:b0:969:edf8:f73b with SMTP id hq37-20020a1709073f2500b00969edf8f73bmr2700075ejc.60.1683645527995;
        Tue, 09 May 2023 08:18:47 -0700 (PDT)
Received: from [127.0.0.1] ([109.139.127.142])
        by smtp.gmail.com with ESMTPSA id hb38-20020a170907162600b009661cf921b4sm1397300ejc.202.2023.05.09.08.18.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 08:18:47 -0700 (PDT)
Date: Tue, 9 May 2023 16:18:47 +0100 (GMT+01:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <c8727f06-5521-4e1b-8958-9168f7e0e572@tessares.net>
Subject: [Weekly meeting] no meeting today
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <c8727f06-5521-4e1b-8958-9168f7e0e572@tessares.net>

Hello,

Just a reminder that there is no weekly meeting today.

Talk to you next week

Matthieu
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
