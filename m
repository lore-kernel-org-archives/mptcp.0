Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0B46AA
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 20:58:56 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-101ec2d6087so5385230fac.3
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=YiukLnuCcsFeDvKRKfWEB6o/9sIaVYaIpOvE+VSbHxc=;
        b=TVqe3b17RnEe+nXzzqKAPFhHKXxjI/SUfU/yvup4EsBX2tWLl/6AXAtTrQUfk4qXW9
         wRPu6VargYpthmu5tDezcBQSoimPHfdUaI06dwGrs9UG7kQCldaafeJLneFWivfUoRTi
         jdsm7stmKN7OAHdU0JhoErVX2W5e5+SNq3E+tkI947iWVqbuofbnhwts7fh0zyz3bxia
         XFLnaSmi52rtrO+BJWHDPeAo9SAkVcAUjNEdoYzHMGDca3sRb+8wiK6pJqKdK2CQUJjA
         inEkNxkQz3UeI+Gex8VOVo8wLUrbI6nsaQvkGqlFFWb4q9WPbzMH0fE/eQyykYLR8yB9
         C1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YiukLnuCcsFeDvKRKfWEB6o/9sIaVYaIpOvE+VSbHxc=;
        b=Qq1gAez49Q/S48qtDclcfhnWbyHCEfJzTqmPfx+OHlAZb0stUkv/MpY1rW9ZEfzV9o
         b0zrBr2KMubAB/rR0lecSUWEOctw7loC/yiB+NMqRVrgPSTmZ83QXYOG/EoUkfKWwrjb
         flqerQgmRDgKjdD6UzgwFRollbHQtrDd2Y/JpYDNnJ0EcMBRSGvhc2wEK1oxS53+L8iS
         kN4A9JelLSplo4ECEmLaLyMg9O9pxuWshcivc2PWBV9+uxjc5GkNtg21Ca8wNeK3sHKF
         ZMV4WyWoZ/tQy57wG8RGWL7T6UJLkv7tjbgVmF5cRKxbwuhM/zyGNtxZtOJqycY2kBKQ
         Kldg==
X-Gm-Message-State: AJIora8/hNx07FhPe/VypqAy1xgQOhtG5qqWAw0GBaFbs5IDVM4NmkZg
	X5xwiERQt77VrsietneVU16wZn9B0F5bF7zRuQNNEF6IC+0=
X-Google-Smtp-Source: AGRyM1sz6/CU0mhSJ061nuk10CKT9VtLVHwyzU/xm4MOAS383MW2K160CrvBou+xTqoBPz9kXhVGwJ6UqNw5892+HUU=
X-Received: by 2002:a05:6870:c092:b0:f1:efd3:ef9e with SMTP id
 c18-20020a056870c09200b000f1efd3ef9emr3284979oad.92.1656104335024; Fri, 24
 Jun 2022 13:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ossama Othman <ossama.othman@gmail.com>
Date: Fri, 24 Jun 2022 13:58:44 -0700
Message-ID: <CAE+88WNQ4J5iBNZMOnLkh+iUgXSQOaHL5ZcU30T4fC0ovh9zrA@mail.gmail.com>
Subject: mptcpd 0.10 released
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Mptcpd 0.10 is now available at:

    https://github.com/intel/mptcpd/releases/tag/v0.10

Notable changes include the following:

- Inconsistent byte order handling in mptcpd was corrected.  IP ports
  sent in path management commands and events now have the correct
  byte order.  Furthermore, the mptcpd unit test suite no longer
  assumes that the tests will be run on a little endian host.  IPv4
  addresses and IP ports used in the mptcpd unit test suite are now
  byte swapped as needed according to the endianness of the platform.
  As always, IPv4 addresses and IP ports passed through pointers to
  struct sockaddr should be in network byte order by convention.

- A potential memory violation caused when attempting to register NULL
  networking monitoring operations with mptcpd was fixed.

- Mptcpd now supports gcc 12.  Link-time errors found in gcc 12 mptcpd
  builds were fixed.

- ELL 0.45 or greater is supported.

- Code coverage was further expanded.

- The mptcpd network monitor supports loopback interface monitoring if
  so desired.

- Improved support for reproducible builds by disabling HTML
  timestamps in Doxygen generated mptcpd documentation.

- Some mptcpd unit tests will be skipped rather than allowed to fail
  on hosts running a kernel without MPTCP support.
