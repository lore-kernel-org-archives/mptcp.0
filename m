Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1471BBBC4
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766723; cv=none; b=n/IWfFYY0fVDLZgVyADsFYPgsEXxLWikZOKoXvVigifNMfcnUedf4NpInxlpcWcb25pjvmKod9BgoFiGPxL8Cd0JjYb4+aItW3vPzSGfUlg+hKkFph3Ef7q7ACBFo2dV8of4wL9GQ3M7opgB2yJgtNsmmRRMgg1SciYOcdWbY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766723; c=relaxed/simple;
	bh=n7Ox06zjAvBIuNEB6mCX71REuQxF9ElNY2Dt96vITZQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=So4RdlLoOeXqGXNghoXKchFAbCUCSLe2J35x99aahxYgwjHfCEzvu+Qz5VyuJnSbXGfv+kVgyFWXHG/8JNY8tAwt+B9U3HtMNXuWOj0STjn98kqIpVdEoC3y6VK7fLn1s7//a6JqXo7j/1QYQMiIOPmGthhno49XLYTqq3BJAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e39Oaal7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e39Oaal7"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbc9a60480so42868417b3.0
        for <mptcp@lists.linux.dev>; Tue, 01 Oct 2024 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727766720; x=1728371520; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46FiudlImA7Mskgq9P8MN+SUxn9yNshmVTDCnL/C6Cs=;
        b=e39Oaal7COcT6Y814ApALa7a+2Y87VEYan3/HYB5jqvIt4qZbMINbhGalkcGydXufU
         UH8hK+mxFA5ZPZo9FG6Ieahd0A4XnJ94ve6UjQPX6u/JQ77aCsf9LNe5SmBKGEdT0zQd
         q/Rk9+qVtKcBZbAqU8w5GjElx6No7V7OubMUFk09gEKoCDhFtojQGZp9mBujGpaLdxZQ
         OgD788SY6Ee5XfWfTJ3uGPx9bTePCa7yFnoWfBi1fMgGyKzOBhIuicFs6ghoUF2DQftc
         /VSAg6mxEIEev5wGDBjjZpDG6/z34hLouVKnPsc5FShcWWu5kh3S8CEzbQW9cWCtXlLr
         72fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727766720; x=1728371520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46FiudlImA7Mskgq9P8MN+SUxn9yNshmVTDCnL/C6Cs=;
        b=NulffzFk24bGL43hq0g9SzhcDreQYK9SkH72Y5Zi4CzO8v/o2vvN8QLkMjsBgN03hf
         qchCsIeL8Uynzpwqt+N92CO0AOnT25ci6aIi8fjDZ33MC4tRWOlqLd/ySpECni9QCtoL
         PHicQeMWn1SljYi/EXUqqkYFTsuo1ap1hJqywGVaQ8YeVK4mtqUAEhlHUJV+NjAflnDP
         cQa5CttivXuASOU+tvukzwh2d9rk18vTfqSqPEnICwO3jQ/ZM1kUZlN2AXwi8ZlFq+gB
         UnV3VP+EVzA/xv8b8N5DJy03YgbmF0OFyiAQIKHFZenChSfXnJLpfm6G9N/+mM4cmXnl
         9N+Q==
X-Gm-Message-State: AOJu0YwW2SwvWhVnOo5vZlC8o2mCf2ufWNo7lLt77NQH0HO6xZalCOO9
	pcEB1wMBeqUjXp+tXuACAgQkxeSyI5w0OKfNmMY93vqe0bONkpSr1RXF
X-Google-Smtp-Source: AGHT+IFpULaF1C3+7rLrSAh9xKcG7qrztgRHxQhq1s8Va/TJDnuF9iO6UZPOYT5scJMOM2ThImbEfA==
X-Received: by 2002:a05:690c:6303:b0:6db:ddea:eab4 with SMTP id 00721157ae682-6e247610978mr124886737b3.37.1727766720472;
        Tue, 01 Oct 2024 00:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.88.186])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2453698fcsm18492337b3.77.2024.10.01.00.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:11:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/7] add mptcp_subflow bpf_iter
Message-ID: <96f0dd6e-62ce-6aa4-25aa-4d65c0842013@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Oct 2024 07:11:57 +0000
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
net-next/actions/runs/11120333547

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1c=
40aee13c8a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D894364

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
