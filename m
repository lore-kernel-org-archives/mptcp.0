Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735F1A9B24
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767520962; cv=none; b=ne8U2GSEVAY2kOLvQK9jm92cX+Y3rSto8J8K5Un5buS0fAUWK6hmsLiv10qm3Iq+ragGQMA4uqSq8eAobe73UmY8vby3+Ac+7JZXt0ILNoP8v1vDa3rP/oQ8n2YqnNXVFD0OX9ehsB2tN6P2RKF1vTA+5jDhu7MxAaGn8TkyLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767520962; c=relaxed/simple;
	bh=JVjfSJawhryCTk2+n/9ATCMSuVeP9TiIHr2sQye4Hyo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZDYB2TOOzLHa8v/m2hSe6dBFc+KJ8jhXe8d4o2z6xn0Gcz0oTBMpom5o4cUuccjEGxpeKO+frQfE/JU62/xEzTCHPH82YCaZSE5UCFZNZ/YSBDv/APUGDXRcarQJdiLejHdLkBFlmlw7zgDghdSIikC2cw8h99wbAbymKVV9t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8lKaYe4; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8lKaYe4"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4f1899960f0so167170701cf.1
        for <mptcp@lists.linux.dev>; Sun, 04 Jan 2026 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767520960; x=1768125760; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4ZUH4Q4Ehps/o1tDjWP4ATVo8Hq0sTwa94lqPoWeBw=;
        b=O8lKaYe4S5GkCxsyiUneMSX7MGkMHXLkWCQ1QUj7B6TtennY9bJP9ySzyC6rPewNrU
         cqRNUqzsVZKM1A2ZPkQ3l3Te6Ld4kPdyqlbvjSlcZnluGC7LBCNEx31iNp6qiEKs3VUY
         ZsgiH6b/xt7kUDpFijSmTHiOlNMQcgBHezl6KjEEmGfw0KRPZ3ufHp6WBXG/w6b0wHxH
         n+hDezbEjb1umRtnNHFL1acaXqBA1K3ylUyUOS6ICIdQ8Vh7VtS1v8Glv6kOOpnOkBOL
         ZpfhfKCvdDpFPQHDnMVKi4iyKkMVNAScONrgaMtlcpGu9TrtO8Ioty9aNICBRAo7/PnJ
         NUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767520960; x=1768125760;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4ZUH4Q4Ehps/o1tDjWP4ATVo8Hq0sTwa94lqPoWeBw=;
        b=fzuEuoNWsn4f9raA8VAMlYGCnDGNW7xh29NApI1ulnBuVdrnCMgWkJrItEr0xelh3x
         uli6KxjE9o6jXvzGbmeIVeRAJeqojSl8ojsn16N5hMCsojzxrEVJXNX3a6oo5G+0IUYT
         tYR6XQE5jjHOr+jtNS9tJ1vhVaefvKuSGl5b/BGx9ceaEUd0ApanCeDJAHNxLnfW7DvJ
         IHKAFiilTxJ7jhWuA146vffNK+F+sVJyuvWTMgPtVvz1LlKD04bWoJ/QcbMMuOZFMEpP
         N/Hm6FyetcZ231phqbqxaZdlgn6JYT5Kx52FWKl0wD/Fm4ND5S/wR+UrPmIF3x1PTwjt
         6J0g==
X-Gm-Message-State: AOJu0Yy+hL6avSrAEvj1ZFtBjxDAVssjzlZBw046uaShKL4uOvnYsxIC
	CChDEhzY6UfNw/tnOI6DR8vwFP4J831lyp/acoT5nVUjXZEqdNaAQ9DTF4Kz3zY=
X-Gm-Gg: AY/fxX5TmWJzZy7m/03cMHWHv/LFIDyU3rbtJcDDVjLnPSs8t/71t8SXv8zVgAlw3yx
	pKWm89mnbWqwmnkreqy3Dl6c7UyaT8bbR6TnhWamK9xRyZ5y44CrVh+mZFHwgeYnqRh8ycqcJXO
	Jed7x2QrVjtdCrqEINX2Ny/QJd4baNu7frm9yRVk28/LJV+m7Px87UogT2fkX1C6SpfkYcRuIQf
	7dEhBAUT/EwdmM7Tvg+mMJg41RI1I0/5YmJpmlHd56x5Q2F7qA5WmDSHB0Vn3bnJ7HDaazIsvFz
	E47rUPMRljOK2uT1CZi6MZAAixJvbeD1fsft5Wj6EqiT8eEPLW9sojfuaDjP2hDLfSViiO0yY97
	ruuzpFfiOcUk/2JsjxNuk9K9+SggW6KuukqTXTxE6jBgq2J7y+m1L/E6XeR7NqlCutUw7ve2WCZ
	oMxL299O5x/6qBy6vk8O+pU2wT7VGqJWPZvu/4nJHU+Ws=
X-Google-Smtp-Source: AGHT+IFFz+VNKA0euWbx8EPNeMs51o3GV4lM+tSdfDpYQCyRxLblx2MdlGJhZdnMtYSKjgDxOSHLpQ==
X-Received: by 2002:a05:622a:40c4:b0:4ed:bad6:9fa9 with SMTP id d75a77b69052e-4f4abcb89a9mr692093371cf.6.1767520959691;
        Sun, 04 Jan 2026 02:02:39 -0800 (PST)
Received: from [127.0.0.1] ([20.236.100.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac55fe70sm320537641cf.11.2026.01.04.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:02:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v6 00/10] MPTCP KTLS support
Message-ID: <5a4be378-d24e-a57d-47a6-0a30ab2777bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Jan 2026 10:02:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/20691127358

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a5=
cdb3d625cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1038175

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
