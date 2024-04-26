Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981913A276
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110603; cv=none; b=rDR+V06ETQbBYWg4W/pxD5dgkdlz5MGw8Yh2OKOBXQehdj7mnYXiLpmi1GKZo4N4ZwPATDTCSu4ObSAgt29LEev3ppOFUskk/DIpikGD35HXaASvlZsl9FZ07AZlXglelVI8iW02p/vg6EIJEYZB47CL8dOdeyGSjVuvwrzRroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110603; c=relaxed/simple;
	bh=b77+4Vnn35cz0MrdKiN3g+GM9LEAOjH34hpvujazC/I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N4lrtHVMLNlDigpqiF5rXge9relrpU6g3HtpvVzMBob/24jdVK+ydRO0JnUPsMIKwRX87o3bNxaidwTusJn67XQfvxAkSemyoNoWS6LtQSjteeaomujSOU6pkb6FXnipr8YlM6h4NCQ89K7aEFuq2i+WkuuRS/0J9LqxPMmByPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrKQe6J7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrKQe6J7"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de462f3d992so1992919276.2
        for <mptcp@lists.linux.dev>; Thu, 25 Apr 2024 22:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714110601; x=1714715401; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b77+4Vnn35cz0MrdKiN3g+GM9LEAOjH34hpvujazC/I=;
        b=lrKQe6J72X6vjBtTDz04jmys11zo4b8njyEKJ0jIsp4rYPpAx6JqLFt9xHjybUoqis
         zXTUf7Mqhg+ixYu6VIa5rnI/wygF2XSwRXX6dabwlwEgxjy6MzMXtRFiARbQ9ZyNEa49
         EK3x/hdAD7lSsvDhlZqIZSieluDVCsWTo3OUFJroHeNjch+7CbnZEGfJEEXMc/2iBdhF
         lVG+l/vEFObeqW/MWRPbS2pMKH/K0IGjnn5qYTepNwi5pmlfklmVztusCy6gUHHvAuOP
         deKWP9XZUP9yPUPqRQRg2wNcbdBGkFBQgLv+PQDvCHUwhSLGXnOMmumS18rggivEMjIg
         a8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110601; x=1714715401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b77+4Vnn35cz0MrdKiN3g+GM9LEAOjH34hpvujazC/I=;
        b=cV9vxKPXP35M6xaCbpVZKFfl1/11XQNjS8KNshIWibvKAKddPtBVyULpF/OpTPRo/9
         FPwK3+r0LAZHPmhWlzbBfZTvnh8Ln886KHfMGT8LeYvkjY/wC2ep3+RaM0G5HbZRAYMf
         U8QfyHCJpP0PqvZ/d0QPHJIUne1472y38RWWKFHaMnxLK+JqgR4qYp7ZTIKVC+zWq5x7
         wcXR7DVzuHd4vFqveQ1yOCgDgqG1pHvcydSEJJ08TUvTcIXbWqoxKINjhLSebTUuUh3d
         mgp1MdUk9AlC8xStfEtHFHE/QNLFzQFfEcIZ/LfYAHzpHdKAm992351+4UbQ7wdmLR2/
         In8w==
X-Gm-Message-State: AOJu0YwTNyTL/TWhV2jUAuCZfUVj0MnLLhy/iCs8sMsBSkGvb0deVcJ+
	lu1WxSjFC5CNh885I7jjAX+Evy3Y1yUYLNcC7b2ruy/MpwkUWf+f6RGgdoXvAtMVCNAuypU9lW7
	xePmejTDzwwS4houIC5tYph4bHpGLXpai
X-Google-Smtp-Source: AGHT+IGBQ7hgnABhj8IA3qZ0dFyGgjx9j4PGtjf0b/npWfFRXJqGu37cbG00e4X+YqXWO+w9JvLavR3KgWInA6cwjok=
X-Received: by 2002:a05:690c:6308:b0:615:6f95:489d with SMTP id
 ho8-20020a05690c630800b006156f95489dmr1920900ywb.3.1714110600759; Thu, 25 Apr
 2024 22:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Haathim Munas <haathimmunas@gmail.com>
Date: Fri, 26 Apr 2024 11:19:50 +0530
Message-ID: <CACObUf_KcUnyUtR=Uzt32b3E1XgVuQ5Z8u9QuWhOzaTgjUvqGw@mail.gmail.com>
Subject: Regarding data-level length in DSS option
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear All,
Note: I am using MPTCP version 0.
I would like to know why it is that when I use the default scheduler,
there exists some packets in the communication where the server adds a
common DSS option for several TCP packets making the data-level length
larger than the TCP payload length. I thought the only time the
data-level length is different to the TCP payload length is when there
is a DATA_FIN flag set (which makes data-level length payload length +
1) . Also why does this happen only when using the default scheduler
and not when using the round robin scheduler?

Hope you could clarify this for me.

Thanks,
Haathim.
